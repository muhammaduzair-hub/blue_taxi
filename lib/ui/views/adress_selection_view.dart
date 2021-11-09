import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/widgets/custom_text_field.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/viewmodels/views/adress_selection_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AdressSelectionView extends StatelessWidget {
  const AdressSelectionView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AdressSelectionViewModel>(
      model: AdressSelectionViewModel(authRepository: Provider.of(context)),
      builder: (context, model, child) => SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(target: LatLng(	33.738045,73.084488,),zoom: 15),
                  mapType: MapType.terrain,
                  onTap: (latlng){
                    print("${latlng.latitude}     ${latlng.longitude}");
                  },
                ),
                LeadindBackButton(
                  ontap: (){Navigator.pop(context);},
                  icon: AssetImage('asset/icons/nav btn.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text("Select address",style: boldHeading1.copyWith(color: onPrimaryColor),),
                  ),
                ),
                DraggableScrollableSheet(

                  initialChildSize: 0.4,
                  minChildSize: 0.4,
                  maxChildSize: 0.8,
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
                            UIHelper.verticalSpaceMedium,
                            //TextField(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(image:AssetImage('asset/icons/ic_route.png')),
                                  UIHelper.horizontalSpaceSmall,
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 30,width: 250,
                                        child: TextField(
                                          textInputAction: TextInputAction.next,
                                          autofocus: true,
                                          decoration: InputDecoration.collapsed(),
                                          controller: model.toController,
                                        ),
                                      ),
                                      Image(image:AssetImage('asset/icons/line.png')),
                                      UIHelper.verticalSpaceSmall,
                                      SizedBox(
                                          height: 30,width: 250,
                                          child: TextField(
                                            textInputAction: TextInputAction.done,
                                            decoration: InputDecoration.collapsed(),
                                            controller: model.fromController,
                                          ),
                                      ),
                                   ],
                                  )
                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Flexible(child: TextField(),fit: FlexFit.,),
                                  //     //TextField(),
                                  //     //UIHelper.verticalSpaceSmall,
                                  //     // Text("test"),
                                  //     // Text("test"),
                                  //     // Text("test"),
                                  //     Image(image:AssetImage('asset/icons/line.png')),
                                  //     UIHelper.verticalSpaceSmall,
                                  //     Text("test")
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                            UIHelper.verticalSpaceMedium,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image(image: AssetImage('asset/icons/ic_dest.png'),height: 20,),
                                UIHelper.horizontalSpaceSmall,
                                Text("Show on map",style: heading2.copyWith(color: secondaryColor),)
                              ],
                            ),
                            UIHelper.verticalSpaceMedium,
                            UIHelper.verticalSpaceSmall,
                            Text("Recent",style: boldHeading3.copyWith(color: onPrimaryColor2),),
                            UIHelper.verticalSpaceSmall,
                            leadingListTile(),
                            Image(image:AssetImage('asset/icons/line.png')),
                          ],
                        )
                    ),
                  ),
                ),
              ],
            )
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
