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
import 'package:group_list_view/group_list_view.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AdressSelectionView extends StatelessWidget {

   AdressSelectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
       builder: (context, orintation, screenType){
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
                         padding: EdgeInsets.only(top: 2.h),
                         child: Align(
                           alignment: Alignment.topCenter,
                           child: Text(model.state,style: boldHeading1.copyWith(color: onPrimaryColor),),
                         ),
                       ),

                       if(model.state==LabelSelectAdress)selectAdressBottomSheet(model)
                       else if(model.state==LabelRideOption) rideOptionBottomSheet(model , context)
                       else if(model.state == LabelPaymentOption)  paymentOptionBottomSheet(model),
                     ],
                   )
               ),
             ),
           ),
         );
       },
    );
  }

  Widget selectAdressBottomSheet(AdressSelectionViewModel model){
    return DraggableScrollableSheet (
      key: model.adressSelectionKey,
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) => ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        //height:80%
        child: Container(
            color: onSecondaryColor,
            //padding: UIHelper.pagePaddingSmall.copyWith(top: 0),
            padding: EdgeInsets.only(
              top: 1.h,
              left: 3.w,
              right: 3.w,
             // bottom: 2.h,
            ),
            child:
                //Height: 77%
            ListView(
              physics: NeverScrollableScrollPhysics(),
              controller: scrollController,
              children: [
                Center(
                    child: Image(
                      image: AssetImage('asset/icons/ic_gesture.png'),
                      height: 1.h,
                    )
                ),
                SizedBox(height: 2.h,),
                //Height:74%
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0,3),
                      )
                    ]
                  ),
                  padding: EdgeInsets.only(
                    top: 1.h,bottom: 1.h,
                    right: 2.w,left: 2.w
                  ),
                  //Height:72%
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(image:AssetImage('asset/icons/ic_route.png')),
                      UIHelper.horizontalSpaceSmall,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h,),
                          SizedBox(
                            height: 3.h,
                            width: 80.w,
                            child:
                            TextField(
                              onTap: (){
                                model.selectedfromTextField = true;
                                model.setBusy(false);
                              },
                              controller: model.fromController,
                              decoration: InputDecoration.collapsed(hintText: 'From'),
                              onChanged: (val){
                                model.debouncer.run(() {
                                  print(model.fromController.text);
                                  if(model.fromController.text.length>3)model.searchAdressOnTextField(model.fromController.text);
                                  else showToast("Enter Minimum 4 Characters");
                                });
                              },
                              textInputAction: TextInputAction.next,
                              onSubmitted: (v){model.switchTextField();},
                            )
                          ),
                          SizedBox(height: 1.h,),
                          Image(image:AssetImage('asset/icons/line.png'),),
                          SizedBox(height: 1.h,),
                          SizedBox(
                              height: 3.h,
                              width: 80.w,
                            child:
                              TextField(
                                onTap: (){
                                  model.switchTextField();
                                },
                                controller: model.toController,
                                decoration: InputDecoration.collapsed(hintText: 'To'),
                                onChanged: (val){
                                  model.debouncer.run(() {
                                    print(model.toController.text);
                                    if(model.toController.text.length>3)model.searchAdressOnTextField(model.toController.text);
                                    else showToast("Enter Minimum 4 Characters");
                                  });
                                },
                                textInputAction: TextInputAction.done,
                                onSubmitted: (v){},
                              )
                          ),
                          SizedBox(height: 1.h,),
                        ],
                      )
                    ],
                  ),
                ),

                SizedBox(height: 4.h),
                //Height:58%
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(image: AssetImage('asset/icons/ic_dest.png'),height: 3.h,),
                    UIHelper.horizontalSpaceSmall,
                    Text("Show on map",style: heading2.copyWith(color: secondaryColor),)
                  ],
                ),
                SizedBox(height: 4.h,),
                //Height:52%
                model.busy?Center(child: CircularProgressIndicator()):Container(
                  height: 50.h,
                  //group list view
                  child:
                    GroupListView(

                      controller: scrollController,
                      sectionsCount: model.groupList.keys.toList().length,
                      countOfItemInSection: (int section){
                        return model.groupList.values.toList()[section].length;
                      },
                      itemBuilder: (context, index) =>
                        leadingListTile(
                          title: model.groupList.values.toList()[index.section][index.index],
                          model: model, controller: scrollController,
                        ),
                      groupHeaderBuilder: (context, section) =>
                          Text(model.groupList.keys.toList()[section],
                            style: boldHeading3.copyWith(color: onPrimaryColor2),
                          ),
                      separatorBuilder: (context, index) => Image(image:AssetImage('asset/icons/line.png')),
                      //sectionSeparatorBuilder: (context, section) => UIHelper.verticalSpaceMedium,
                    )
                ),
              ],
            )
        ),
      ),
    );
  }

   rideOptionBottomSheet(AdressSelectionViewModel model, BuildContext screenContext) {
   return DraggableScrollableSheet (
     key:model.othersSheetKey ,
      maxChildSize: 0.4,
      minChildSize: 0.4,
      initialChildSize: 0.4,
      builder: (context, scrollController) => ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        child: Container(
          padding: EdgeInsets.only(right: 3.w, left: 3.w,top: 1.h),//,bottom: 1.h
          color: onSecondaryColor,
          //height:40%
          child: ListView(
            controller: scrollController,
            children: [
              //list view
              Container(
                height: 21.h,
                padding: EdgeInsets.only(left: 3.w,right: 3.w), //UIHelper.pagePaddingSmall.copyWith(bottom: 10),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: model.vehiclesList.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(width: 2.w,),
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
                              Image(image: AssetImage(model.vehiclesList[index].vPic),height: 10.h,),
                              Text(model.vehiclesList[index].vName,style: TextStyle(fontSize: 2.h),),
                              Text(model.vehiclesList[index].vRate,style: TextStyle(fontSize: 2.h),),
                              SizedBox(height: 1.h,),
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  padding: EdgeInsets.all(1.h),
                                  color: onPrimaryColor2,
                                  child: Text(model.vehiclesList[index].vArrivingTime
                                    ,style:boldHeading3.copyWith(color: onSecondaryColor,fontSize: 2.h) ,),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )

                ),
              ),
              //Height:22%
              //Payment List tile
              ListTile(
                onTap:(){},
                title: Text(LabelEstimateTripTime,style:heading3.copyWith(color: onPrimaryColor2) ,),
                subtitle: Text("${model.distance.toInt()*3} min and \$${model.bill.toInt()}",style: heading3.copyWith(color: secondaryColor),),
                trailing: InkWell(
                  onTap: (){
                    if( model.myCards.length==1) showToast("You Don't Have Any Card");
                    else model.switchState(LabelPaymentOption);
                    },
                  child: Wrap(
                    spacing: 3,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image(image: model.myCards[model.selectedCardIndex].leadingImage),
                      Text(model.myCards[model.selectedCardIndex].cardNumber,style: heading3),
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

                    //await model.checkDriver();
                    dynamic driver= await model.getDriverDetails();
                    print("*******We Got this*******$driver***********");

                    if(driver==null){
                      showToast("No Driver Available Currently");
                    }
                    else {
                      print("Driver Found");
                      await  model.generateRequest();
                      if(requestId!='-') {
                        Navigator.push(screenContext, MaterialPageRoute(builder: (
                            screenContext) => ArrivingScreen(requestedId: requestId!,),));
                      }
                      else{
                        showToast("You Currently have an OnGoing Ride");
                      }
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
      key: model.cardSheet,
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.4,
      builder: (context, scrollController) => ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        child: Container(
            color: onSecondaryColor,
            padding: UIHelper.pagePaddingSmall.copyWith(top: 20),

          child: model.busy?Center(child: CircularProgressIndicator()):
            model.myCards.length==0? Center(child: Text("You Don't have any Card",style: heading1,),):
            ListView.separated(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: model.myCards.length,
              separatorBuilder: (context, index) => UIHelper.verticalSpaceSmall,
              itemBuilder: (context, index) =>
                  paymentOptionListTile(
                    leadingImage: model.myCards[index].leadingImage,
                    text: model.myCards[index].cardNumber,
                    trailingImage: AssetImage("asset/icons/ic_arrow (2).png"),
                    index: index,
                    model: model
                  ),
            ),
        ),
      ),
    );
  }

  Widget paymentOptionListTile({
    required AssetImage leadingImage,
    required String text,
    required AssetImage trailingImage,
    required AdressSelectionViewModel model ,
    required int index}) {
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
        trailing:model.selectedCardIndex==index?Image(image: AssetImage("asset/icons/check.png"),height: 15,): Image(image: trailingImage,),
        onTap: (){
          model.switchSelectCardIndex(index);
          model.switchState(LabelRideOption);
        },
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
        //Working on From Text Field
        if(model.selectedfromTextField){
          model.selectSearchItem(model.fromController, title);
          model.selectedAddresses.add(model.fromController.text);
          model.setBusy(false);
          if(!model.checkToTextFieldval && model.toController.text.length>0) {
            model.checkToTextField();
            if(model.checkToTextFieldval){
              if(model.toController.text!=model.fromController.text){
                model.showonMap();
                model.switchState(LabelRideOption);
                model.remoteAdressTitle.clear();
                model.initializegroupList(model.localAdressTitles);
                model.setBusy(false);
                controller.animateTo(controller.position.minScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.ease);
              }
              else
                showToast("Initial And Destination Address Must Not Be Same");
            }
            else{
              model.selectedAddresses.add(model.fromController.text);
              model.setBusy(false);
              showToast("Invalid Destination Address");
            }
          }
        }
        else{
          model.selectSearchItem(model.toController, title);
          model.checkFromTextField();
          if(model.selectedfromTextField) {
            if(model.toController.text!=model.fromController.text){
              model.showonMap();
              model.switchState(LabelRideOption);
              model.remoteAdressTitle.clear();
              model.initializegroupList(model.localAdressTitles);
              model.setBusy(false);
              controller.animateTo(controller.position.minScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.ease);
            }
            else
              showToast("Initial And Destination Address Must Not Be Same");
            }
          else
          {
            showToast("Invalid Initial Address");
            model.selectedfromTextField=true;
            model.checkToTextFieldval =false;
            model.selectedAddresses.add(model.toController.text);
            model.setBusy(false);
          }
        }
      },
    );
  }
}
