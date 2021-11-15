import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/adress_selection_view.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/viewmodels/views/boooking_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BookingView extends StatelessWidget {
  final UserModel signInUser;
  const BookingView({Key? key, required this.signInUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<BookingViewModel>(
      model: BookingViewModel(authRepository: Provider.of(context),context: context),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: model.onMapCreated,
                markers: Set.of(model.markers),
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(target: LatLng(	33.738045,73.084488,),zoom: 15),
                mapType: MapType.terrain,
                onTap: (latlng){
                  print("${latlng.latitude}     ${latlng.longitude}");
                },
              ),
              LeadindBackButton(icon: AssetImage('asset/icons/drawer btn.png'), ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>UserMenuView() ,));
              }),
              Align(
                alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      SizedBox(height:  380,),
                      LeadindBackButton(
                          icon: AssetImage('asset/icons/btn_loc.png'),
                          ontap: () async{
                            await model.getCurrentLocation();
                            model.loadCurrentLocationMarler();
                            model.goToPositone();
                          }
                        ),
                    ],
                  )
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.4,
                maxChildSize: 0.4,
                builder: (context, scrollController) => ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  child: Container(
                    color: onSecondaryColor,
                    padding: UIHelper.pagePaddingSmall.copyWith(top: 0),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        UIHelper.verticalSpaceSmall,
                        Center(
                            child: Image(
                              image: AssetImage('asset/icons/ic_gesture.png'),
                            )
                        ),
                        // UIHelper.verticalSpaceMedium,
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AdressSelectionView(signInUser: signInUser,),));
                          },
                          child: Container(
                            margin: UIHelper.pagePaddingSmall.copyWith(bottom: 0),
                            padding: UIHelper.pagePaddingSmall.copyWith(bottom: 0,top: 0),
                            height: 40,
                            decoration: BoxDecoration(
                              color: onSecondaryColor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(children: [Icon(Icons.search,color: secondaryColor,)],)
                          ),
                        ),
                        UIHelper.verticalSpaceSmall,
                        leadingListTile(),
                        Padding(
                          padding: EdgeInsets.only(left: 60,right: 20 ),
                          child: Divider(),
                        ),
                        leadingListTile(),
                        Padding(
                          padding: EdgeInsets.only(left: 60,right: 20 ),
                          child: Divider(),
                        ),
                        leadingListTile(),
                      ],
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget leadingListTile(){
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('asset/icons/ic_place.png'),
      ),
      title: Text('Kings',style: heading2,),
      subtitle: Text("New york",style: heading3,),
    );
  }
}
