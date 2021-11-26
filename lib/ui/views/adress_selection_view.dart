import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/arriving_screen_view.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
import 'package:bluetaxiapp/viewmodels/views/adress_selection_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:group_list_view/group_list_view.dart';

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
                    markers: Set.of(model.markers),
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(target: LatLng(	33.738045,73.084488,),zoom: 15),
                    mapType: MapType.terrain,
                    onTap: (latlng){
                      print("${latlng.latitude}     ${latlng.longitude}");
                    },
                  ),

                  //Navigator Button
                  // if(model.busy)CircularProgressIndicator()
                  // else
                    if(model.state==LabelSelectAdress)
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
      initialChildSize: 0.8,
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
                            height: model.addressSelection_FromSearchTextFieldInitialSize.toDouble(),
                            width: 250,
                            child:
                            TextField(
                              controller: model.fromController,
                              decoration: InputDecoration.collapsed(hintText: 'To'),
                              onChanged: (val){
                                model.debouncer.run(() {
                                  print(model.fromController.text);
                                  if(model.fromController.text.length>3)model.searchAdressOnTextField(model.fromController.text);
                                });
                              },
                              textInputAction: TextInputAction.next,
                              onSubmitted: (v){model.switchTextField();},
                            )
                          ),
                          Image(image:AssetImage('asset/icons/line.png')),
                          UIHelper.verticalSpaceSmall,
                          SizedBox(
                            height: model.addressSelection_ToSearchTextFieldInitialSize.toDouble(),
                            width: 250,
                            child:
                              TextField(
                                onTap: (){
                                  model.switchTextField();
                                },
                                controller: model.toController,
                                decoration: InputDecoration.collapsed(hintText: 'From'),
                                onChanged: (val){
                                  model.debouncer.run(() {
                                    print(model.toController.text);
                                    if(model.toController.text.length>3)model.searchAdressOnTextField(model.toController.text);
                                  });
                                },
                                textInputAction: TextInputAction.done,
                                onSubmitted: (v){
                                  model.switchState(LabelRideOption);
                                },
                              )
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

                UIHelper.verticalSpaceSmall,
                Container(
                  height: 500,
                  //group list view
                  child:
                    GroupListView(
                      sectionsCount: model.groupList.keys.toList().length,
                      countOfItemInSection: (int section){
                        return model.groupList.values.toList()[section].length;
                      },
                      itemBuilder: (context, index) =>
                        leadingListTile(
                          title: model.groupList.values.toList()[index.section][index.index],
                          model: model,
                          controller: scrollController
                        ),
                      groupHeaderBuilder: (context, section) =>
                          Text(model.groupList.keys.toList()[section],
                            style: boldHeading3.copyWith(color: onPrimaryColor2),
                          ),
                      separatorBuilder: (context, index) => Image(image:AssetImage('asset/icons/line.png')),
                      sectionSeparatorBuilder: (context, section) => UIHelper.verticalSpaceMedium,
                    )
                  // ListView.separated(
                  //   controller: scrollController,
                  //   itemCount: model.adressList.length,
                  //   separatorBuilder:  (context, index) => Image(image:AssetImage('asset/icons/line.png')),
                  //   itemBuilder: (context, index) =>
                  //       leadingListTile(
                  //         title: model.adressList[index].adressTitle,
                  //         model: model
                  //       ),
                  // ),
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
            controller: scrollController,
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
                        opacity: model.vehicleSelectedIndex==index?1:0.5,
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
                                  child: Text(model.vehiclesList[index].vArrivingTime
                                    ,style:boldHeading3.copyWith(color: onSecondaryColor) ,),
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
                onTap:(){},
                title: Text(LabelEstimateTripTime,style:heading3.copyWith(color: onPrimaryColor2) ,),
                subtitle: Text("${model.distance.toInt()*3} min",style: heading3.copyWith(color: secondaryColor),),
                trailing: InkWell(
                  onTap: (){ model.switchState(LabelPaymentOption);},
                  child: Wrap(
                    spacing: 3,
                    children: [
                      Image.asset("asset/icons/ic_mastercard.png"),
                      Text("**** 8295",style: heading3,),
                    ],
                  ),
                ),
              ),
              Container(
                margin: UIHelper.pagePaddingSmall.copyWith(bottom: 0,top: 0),
                width: double.infinity,
                child:
                model.busy?
                Center(child: CircularProgressIndicator(),) :
                PrimaryButton(
                  ontap: ()async {
                    await model.addAdress(model.toController.text);
                    await model.addAdress(model.fromController.text);
                    model.initializegroupList(model.localAdressTitles);
                    await model.generateRequest();


                    if(requestId!="") {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => ArrivingScreen(requestedId: requestId,),));
                    }
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
            padding: UIHelper.pagePaddingSmall.copyWith(top: 20),
            child: ListView.separated(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: model.myCards.length,
              separatorBuilder: (context, index) => UIHelper.verticalSpaceSmall,
              itemBuilder: (context, index) =>
                  paymentOptionListTile(
                    leadingImage: model.myCards[index].leadingImage,
                    text: model.myCards[index].cardNumber,
                      trailingImage: AssetImage("asset/icons/ic_arrow (2).png")
                  ),
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

  Widget leadingListTile({required String title, required AdressSelectionViewModel model, required ScrollController controller }){
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('asset/icons/ic_place.png'),
      ),
      title: Text(title,style: heading2,),
      //subtitle: Text("New york",style: heading3,),
      onTap: (){
        if(model.selectedfromTextField) model.selectSearchItem(model.fromController, title);
        else{
          model.selectSearchItem(model.toController, title);
          model.showonMap();
          model.switchState(LabelRideOption);
        }
        controller.animateTo(controller.position.minScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
    );
  }
}
