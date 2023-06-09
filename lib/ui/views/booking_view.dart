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
  const BookingView({Key? key}) : super(key: key);

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
                Navigator.push(context, MaterialPageRoute(builder: (context) =>UserMenuPageView() ,));
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
                key: Key("Sheet"),
                initialChildSize:0.25,//model.localAdressTitles.length!=0?0.4:0.2,
                minChildSize: 0.25,
                maxChildSize: 0.4,
                builder: (context, scrollController) => ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  child: Container(
                      color: onSecondaryColor,
                      padding: UIHelper.pagePaddingSmall.copyWith(top: 0,bottom: 0),
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AdressSelectionView(),));
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
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: model.localAdressTitles.length,
                            separatorBuilder: (context, index) => Image(image:AssetImage('asset/icons/line.png')),
                            itemBuilder: (context, index) => (
                                leadingListTile(title: model.localAdressTitles[index].toString())
                            ),
                          ),
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

  Widget leadingListTile({required String title}){
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('asset/icons/ic_place.png'),
      ),
      title: Text(title,style: heading2,),
      //subtitle: Text("New york",style: heading3,),
      onTap: (){},
    );
  }
}
