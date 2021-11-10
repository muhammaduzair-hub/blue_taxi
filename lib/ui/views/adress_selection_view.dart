import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
import 'package:bluetaxiapp/viewmodels/views/adress_selection_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AdressSelectionView extends StatelessWidget {
  const AdressSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AdressSelectionViewModel>(
      model: AdressSelectionViewModel(authRepository: Provider.of(context)),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async{
          if(model.state==LabelSelectAdress){
            return true;
          }
          else if(model.state==LabelRideOption){
            model.switchState(LabelSelectAdress);
            return false;
          }
          else{
            model.switchState(LabelRideOption);
            return false;
          }
        },
        child: SafeArea(
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

                  //Navigator Button
                  if(model.busy)CircularProgressIndicator()
                  else if(model.state==LabelSelectAdress)
                    LeadindBackButton(
                      ontap: (){Navigator.pop(context);},
                      icon: AssetImage('asset/icons/nav btn.png'),
                    )
                  else if(model.state == LabelRideOption)
                      LeadindBackButton(
                          icon: AssetImage('asset/icons/nav btn.png'),
                          ontap: (){model.switchState(LabelSelectAdress);}
                          )
                  else if(model.state == LabelPaymentOption)
                    LeadindBackButton(
                        icon: AssetImage('asset/icons/nav btn.png'),
                        ontap: (){model.switchState(LabelRideOption);}
                    ),


                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(model.state,style: boldHeading1.copyWith(color: onPrimaryColor),),
                    ),
                  ),

                  //bottom sheets
                  if(model.busy) Align(alignment: Alignment.center,child: CircularProgressIndicator(),)
                  else if(model.state==LabelSelectAdress)selectAdressBottomSheet(model)
                  else if(model.state==LabelRideOption) rideOptionBottomSheet(model)
                  else if(model.state == LabelPaymentOption)  paymentOptionBottomSheet(model),
                ],
              )
            ),
        ),
      ),
    );
  }

  Widget selectAdressBottomSheet(AdressSelectionViewModel model){
    return DraggableScrollableSheet (
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.5,
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
                    color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
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
                              //textInputAction: model.fromController.text.length<3? TextInputAction.none:TextInputAction.next,
                              textInputAction: TextInputAction.next,
                              autofocus: true,
                              decoration: InputDecoration.collapsed(hintText: ''),
                              controller: model.fromController,
                              onChanged: (c){},
                            ),
                          ),
                          Image(image:AssetImage('asset/icons/line.png')),
                          UIHelper.verticalSpaceSmall,
                          SizedBox(
                            height: 30,width: 250,
                            child: TextField(
                              //textInputAction: model.toController.text.length<3? TextInputAction.none:TextInputAction.done,
                              textInputAction: TextInputAction.done,
                              enabled: model.fromController.text.length<3?false:true,
                              decoration: InputDecoration.collapsed(hintText: ''),
                              controller: model.toController,
                              onSubmitted: (v){
                                model.switchState(LabelRideOption);
                              },
                            ),
                          ),
                        ],
                      )
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
                Container(
                  height: 500,
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: model.adressList.length,
                    separatorBuilder:  (context, index) => Image(image:AssetImage('asset/icons/line.png')),
                    itemBuilder: (context, index) =>leadingListTile(title: model.adressList[index].adressTitle),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  Widget rideOptionBottomSheet(AdressSelectionViewModel model) {
    return DraggableScrollableSheet (
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.5,
      builder: (context, scrollController) => ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        child: Container(
          padding: UIHelper.pagePaddingSmall.copyWith(top: 0,bottom: 0),
          color: onSecondaryColor,
          child: ListView(
            children: [
              //list view
              Container(
                height: 170,
                padding: UIHelper.pagePaddingSmall.copyWith(bottom: 10),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: model.vehiclesList.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(width: 10,),
                    itemBuilder: (context, index) => InkWell(
                      onTap: (){
                        model.switchRideOptionButtonIndex(index);
                      },
                      child: AnimatedOpacity(
                        opacity: model.index==index?1:0.5,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: onPrimaryColor2.withOpacity(0.5),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: Offset(0, 3),
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Image(image: AssetImage(model.vehiclesList[index].vPic),),
                              Text(model.vehiclesList[index].vName),
                              Text(model.vehiclesList[index].vRate),
                              UIHelper.verticalSpaceSmall,
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  color: onPrimaryColor2,
                                  child: Text(model.vehiclesList[index].vArrivingTime,style:boldHeading3.copyWith(color: onSecondaryColor) ,),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )

                ),
              ),
              //Payment List tile
              ListTile(
                onTap:(){ model.switchState(LabelPaymentOption);},
                title: Text(LabelEstimateTripTime,style:heading3.copyWith(color: onPrimaryColor2) ,),
                subtitle: Text("24 min",style: heading3.copyWith(color: secondaryColor),),
                trailing: Wrap(
                  spacing: 3,
                  children: [
                    Image.asset("asset/icons/ic_mastercard.png"),
                    Text("**** 8295",style: heading3,),
                  ],
                ),
              ),
              Container(
                margin: UIHelper.pagePaddingSmall.copyWith(bottom: 0,top: 0),
                width: double.infinity,
                child: PrimaryButton(
                  ontap: ()async {
                    await model.addAdress(model.toController.text);
                    await model.addAdress(model.fromController.text);
                  },
                  text: Text(LabelBookRide, ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  Widget paymentOptionBottomSheet(AdressSelectionViewModel model) {
    return DraggableScrollableSheet (
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
                UIHelper.verticalSpaceMedium,
                Text(LabelSelectPayment, style: boldHeading2,),
                UIHelper.verticalSpaceMedium,
                paymentOptionListTile(
                    leadingImage: AssetImage("asset/icons/ic_mastercard.png"),
                    text: "**** 8965",
                    trailingImage: AssetImage("asset/icons/ic_arrow (2).png")
                ),
                UIHelper.verticalSpaceSmall,
                paymentOptionListTile(
                    leadingImage: AssetImage("asset/icons/ic_visa.png"),
                    text: "**** 8965",
                    trailingImage: AssetImage("asset/icons/ic_arrow (2).png")
                ),
                UIHelper.verticalSpaceSmall,
                paymentOptionListTile(
                    leadingImage: AssetImage("asset/icons/ic_cash.png"),
                    text: LabelCash,
                    trailingImage: AssetImage("asset/icons/ic_arrow (2).png")
                ),

              ],
            ),
        ),
      ),
    );
  }

  Widget paymentOptionListTile({required AssetImage leadingImage, required String text, required AssetImage trailingImage }) {
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: onPrimaryColor.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(3,2)
            )
          ]
      ),
      child: ListTile(
        leading: Image(image: leadingImage),
        title: Text(text),
        trailing: Image(image: trailingImage,),
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
      subtitle: Text("New york",style: heading3,),
    );
  }
}
