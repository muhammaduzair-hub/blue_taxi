import 'dart:async';
import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/ui/views/dialPad_View.dart';
import 'package:bluetaxiapp/ui/views/message_view.dart';
import 'package:bluetaxiapp/ui/views/receipt_view.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:bluetaxiapp/ui/widgets/custom_text_field.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart' as leading;
import 'package:bluetaxiapp/ui/widgets/responsive_ui_widgets.dart';
import 'package:bluetaxiapp/viewmodels/views/arriving_view_model.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ArrivingScreen extends StatelessWidget {
  String requestedId;

  ArrivingScreen({Key? key, required this.requestedId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) => BaseWidget<ArrivingSelectionViewModel>(
          model:
          ArrivingSelectionViewModel(requestedId, repo: Provider.of(context)),
          builder: (context, model, child) => model.cancelModel == false
              ? WillPopScope(
            onWillPop: () async {
              if (state == EnumToString.convertToString(Status.Completed)) {
                model.unassignDriver();
                return true;
              }
              return false;
            },
            child: SafeArea(
                child: Scaffold(
                    body: Stack(children: [
                      GoogleMap(
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                              33.738045,
                              73.084488,
                            ),
                            zoom: 15),
                        mapType: MapType.terrain,
                        onTap: (latlng) {
                          print("${latlng.latitude}     ${latlng.longitude}");
                        },
                      ),

                      if (state == EnumToString.convertToString(Status.Active) ||
                          state == EnumToString.convertToString(Status.Completed) ||
                          state == EnumToString.convertToString(Status.Rate))
                        Padding(
                          padding: smallPadding.copyWith(right: 0.0),
                          child: LeadingBackButton(
                            ontap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                      new UserMenuPageView()));
                            },
                            image: AssetImage('asset/icons/navigation_button.png'),
                          ),
                        ),

                      //Chnage Header Text on Model State
                      if (state == EnumToString.convertToString(Status.Active))
                        Padding(
                          padding: smallPadding.copyWith(left: 0.0, right: 0.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              LabelArriving,
                              style: boldHeading1.copyWith(color: onPrimaryColor),
                            ),
                          ),
                        )
                      else if (state == EnumToString.convertToString(Status.OnGoing))
                        Padding(
                          padding: smallPadding.copyWith(left: 0.0, right: 0.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              " On Going",
                              style: boldHeading1.copyWith(color: onPrimaryColor),
                            ),
                          ),
                        )
                      else if (state == EnumToString.convertToString(Status.Completed))
                          Padding(
                            padding: smallPadding.copyWith(left: 0.0, right: 0.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                LabelOnTrip,
                                style: boldHeading1.copyWith(color: onPrimaryColor),
                              ),
                            ),
                          )
                        else if (state == EnumToString.convertToString(Status.Tips))
                            Padding(
                              padding: smallPadding.copyWith(left: 0.0, right: 0.0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Tips Amount",
                                  style: boldHeading1.copyWith(color: onPrimaryColor),
                                ),
                              ),
                            )
                          else if (state == EnumToString.convertToString(Status.Rate))
                              Padding(
                                padding: smallPadding.copyWith(left: 0.0, right: 0.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "Send Feedback",
                                    style: boldHeading1.copyWith(color: onPrimaryColor),
                                  ),
                                ),
                              ),

                      //Chnage Bottom sheets on Model State
                      if (state == EnumToString.convertToString(Status.Booked))
                        selectDriverSearchingSheet(model, context) //Checked
                      else if (state == EnumToString.convertToString(Status.Active))
                        selectArrivingBottomSheet(model) //Checked
                      else if (state ==
                            EnumToString.convertToString(Status.Dispatched))
                          selectArrivedBottomSheet(model, context) //Checked
                        else if (state ==
                              EnumToString.convertToString(Status.OnGoing))
                            selectDisbaledArrivingBottomSheet(model) //Checked
                          else if (state ==
                                EnumToString.convertToString(Status.Completed))
                              selectTipAndRateSheet(model) //Checked
                            else if (state == EnumToString.convertToString(Status.Tips))
                                selectTipsSheet(model)
                              else if (state == EnumToString.convertToString(Status.Rate))
                                  selectRateSheet(model),
                    ]))),
          )
              : _showCancelPanel(context, model)),
    );
  }

  //Booked
  Widget selectDriverSearchingSheet(
      ArrivingSelectionViewModel model, BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {});
    Future<dynamic> driver = model.checkDriver();
    //selectArrivingBottomSheetEnds
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.black26.withOpacity(0.8),
        // Aligns the container to center
        child: Padding(
          padding: smallPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Cancel Reason Button
              Align(
                alignment: Alignment.topLeft,
                child: LeadingBackButton(
                  ontap: () {
                    model.cancelModel = true;
                    model.setBusy(false);
                  },
                  image: AssetImage('asset/icons/btn_cancel.png'),
                ),
              ),

              //Copied Code for Ripple
              Container(
                child: Stack(alignment: Alignment(0, 0), children: <Widget>[
                  Center(
                    //Load a Lottie file from your assets
                    child: Lottie.asset('asset/images/ripple_effect.json'),
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Align(
                        alignment: Alignment.center,
                        child:
                            Image(image: AssetImage('asset/images/carAbove.png')),
                      ),
                    ),
                  )
                ]),
              ),

              //Searching Driver Text
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Searching For Driver",
                  style: boldHeading1.copyWith(color: onSecondaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Active
  Widget selectArrivingBottomSheet(ArrivingSelectionViewModel model) {
    return DraggableScrollableSheet(
      key: model.arrivingBottomKey,
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.4,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),),
        child: Stack(
            overflow: Overflow.visible,
            fit: StackFit.passthrough,
            children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8.0,
                  offset: Offset(0.0, 5.0),
                ),
              ],
            ),
            child: Padding(
              padding: smallPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Center(
                      child: Image(
                    image: AssetImage('asset/icons/ic_gesture.png'),
                  )),
                  Padding(
                    padding: smallPadding.copyWith(right: 0.0, left:0.0, bottom: 0.0,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //DRIVER NAME TAG
                        Text(
                          model.driverModel!.driverName ??
                              "Patrick",
                          style: buttonTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              color: onPrimaryColor),
                        ),

                        //NUMBER PLATE TAG
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: secondaryColor2,
                          ),
                          child: Center(
                            child: Text(
                              model.driverModel!.carNumber ??
                                  '  HS785K  ',
                              style: buttonTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: onPrimaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //CAR NAME TAG
                  Padding(
                    padding: smallPadding.copyWith(bottom: height*0.02, top:0.0, left:0.0, right: 0.0),
                    child: Text(
                      model.driverModel!.carName ??
                          'Volkswagen Jetta',
                      style: heading2.copyWith(
                          fontWeight: FontWeight.w400,
                          color: onPrimaryColor),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      leading.NavButton(
                        radius: width*0.12,
                        ontap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new DialPadView()));
                          },
                          icon: AssetImage('asset/icons/btn_call.png'),
                        ),
                        Container(
                          child: Stack(
                              alignment: Alignment.topRight,
                              children: <Widget>[
                                leading.NavButton(
                                  radius: width*0.12,
                                  ontap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                            new MessageView(model.driverModel!.driverName)));
                                  },
                                  icon: AssetImage(
                                      'asset/icons/btn_chat.png'),
                                ),
                                Positioned(
                                  top: 2.0,
                                  right: 1.0,
                                  child: Container(
                                    height: 24.0,
                                    width: 24.0,
                                    decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius:
                                        BorderRadius.circular(15.0)),
                                    child: Center(
                                        child: Text("2",
                                            style: subHeaderStyle.copyWith(
                                                color:
                                                onSecondaryColor))),
                                  ),
                                )
                              ]),
                        ),
                      leading.NavButton(
                          radius: width*0.12,
                          icon: AssetImage('asset/icons/btn_cancel.png'),
                            ontap: () {
                              model.cancelModel=true;
                              model.setBusy(false);
                            }
                        ),
                      ],
                  ),
                ],
              ),
            ),
          ),

          ///Image Avatar
          Positioned(
            top:-height*0.075,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.22),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6.0, top: 6.0, left: 6.0, right:6.0,),
                child: CustomImage(
                 image: AssetImage('asset/images/Group.png'),
                  ontap: () { },
                  height: height*0.15,
                  width: width*0.22,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  //Dispatched
  Widget selectArrivedBottomSheet(
      ArrivingSelectionViewModel model, BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.black26.withOpacity(0.8),
        // Aligns the container to center
        child: Padding(
          padding: smallPadding,
          child: Column(
            children: [
              //NAVIGATION BUTTON
              Padding(
                padding: smallPadding.copyWith(left:0.0, right: 0.0, top:0.0, bottom: height*0.1),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: LeadingBackButton(
                    ontap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new UserMenuPageView()));
                    },
                    image: AssetImage('asset/icons/navigation_button.png'),
                  ),
                ),
              ),

              //ALERT DIALOGUE
              Container(
                child: ListBody(
                    children: <Widget>[
                  Container(
                    height: height*0.5,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          decoration: BoxDecoration(
                              color: onSecondaryColor,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Padding(
                            padding: smallPadding.copyWith(top: height*0.08, bottom: height*0.06),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image(
                                  fit: BoxFit.contain,
                                  height: height*0.15,
                                    width: width*0.2,
                                    image: AssetImage(
                                        'asset/images/carAbove.png')),
                                Text(
                                  "Your taxi has Arrived",
                                  style: buttonTextStyle.copyWith(
                                      fontWeight: FontWeight.w700),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: width*0.38,
                                        height: height * 0.07,
                                        color: onSecondaryColor,
                                        child: PrimaryButton(
                                          text: Text(
                                            "I'm Coming",
                                            style: buttonTextStyle.copyWith(
                                                color: onSecondaryColor),
                                          ),
                                          ontap: () {
                                            model.switchState(
                                                EnumToString.convertToString(
                                                    Status.OnGoing));
                                          },
                                        )),
                                    Container(
                                      width: width*0.38,
                                        height: height * 0.07,
                                        color: onSecondaryColor,
                                        child: PrimaryButton(
                                          color: Colors.white,
                                          text: Text(
                                            "Call",
                                            style: buttonTextStyle.copyWith(
                                                color: onPrimaryColor),
                                          ),
                                          ontap: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        new DialPadView()));
                                          },
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //OnGoing
  Widget selectDisbaledArrivingBottomSheet(ArrivingSelectionViewModel model) {
    final double circleRadius = 120.0;
    return DraggableScrollableSheet(
      key: model.disbaledArrivingKey,
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.4,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),),
        child: Stack(
            overflow: Overflow.visible,
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: smallPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Center(
                          child: Image(
                            image: AssetImage('asset/icons/ic_gesture.png'),
                          )),
                      Padding(
                        padding: smallPadding.copyWith(right: 0.0, left:0.0, bottom: 0.0,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //DRIVER NAME TAG
                            Text(
                              model.driverModel!.driverName ??
                              "Patrick",
                              style: buttonTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: onPrimaryColor),
                            ),

                            //NUMBER PLATE TAG
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: secondaryColor2,
                              ),
                              child: Center(
                                child: Text(
                                  model.driverModel!.carNumber ??
                                  '  HS785K  ',
                                  style: buttonTextStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: onPrimaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //CAR NAME TAG
                      Padding(
                        padding: smallPadding.copyWith(bottom: height*0.02, top:0.0, left:0.0, right: 0.0),
                        child: Text(
                          model.driverModel!.carName ??
                          'Volkswagen Jetta',
                          style: heading2.copyWith(
                              fontWeight: FontWeight.w400,
                              color: onPrimaryColor),
                        ),
                      ),

                      Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            model.switchToCompletedState();
                            model.switchState(
                                EnumToString.convertToString(
                                    Status.Completed));
                            await Future.delayed(Duration(seconds: 10));
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new ReceiptView(
                                      requestId: model.requestId,
                                    )));
                            model.unassignDriver();
                          },
                          child: const Text('Enjoy Your Ride'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///Image Avatar
              Positioned(
                top:-height*0.075,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.22),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, top: 4.0, left: 4.0, right:4.0,),
                    child: CustomImage(
                      image: AssetImage('asset/images/Group.png'),
                      ontap: () { },
                      height: height*0.15,
                      width: width*0.22,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  //Completed
  Widget selectTipAndRateSheet(ArrivingSelectionViewModel model) {
    final double circleRadius = 120.0;
    return DraggableScrollableSheet(
      key: model.tipAndRateKey,
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.4,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),),
        child: Stack(
            overflow: Overflow.visible,
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: smallPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Center(
                          child: Image(
                            image: AssetImage('asset/icons/ic_gesture.png'),
                          )),
                      Padding(
                        padding: smallPadding.copyWith(right: 0.0, left:0.0, bottom: 0.0,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //DRIVER NAME TAG
                            Text(
                              model.driverModel!.driverName ??
                              "Patrick",
                              style: buttonTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: onPrimaryColor),
                            ),

                            //NUMBER PLATE TAG
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: secondaryColor2,
                              ),
                              child: Center(
                                child: Text(
                                  model.driverModel!.carNumber ??
                                  '  HS785K  ',
                                  style: buttonTextStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: onPrimaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //CAR NAME TAG
                      Padding(
                        padding: smallPadding.copyWith(bottom: height*0.02, top:0.0, left:0.0, right: 0.0),
                        child: Text(
                          model.driverModel!.carName ??
                          'Volkswagen Jetta',
                          style: heading2.copyWith(
                              fontWeight: FontWeight.w400,
                              color: onPrimaryColor),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * 0.06,
                            width: width*0.38,
                            child: PrimaryButton(
                                text: Text(
                                  rate_btn,
                                  style: buttonTextStyle,
                                ),
                                ontap: () {
                                  //switchState
                                  model.switchState(
                                      EnumToString.convertToString(
                                          Status.Rate));
                                }),
                          ),
                          Container(
                            height: height * 0.06,
                            width: width*0.38,
                            child: PrimaryButton(
                                color: onSecondaryColor,
                                text: Text(
                                  tips_btn,
                                  style: buttonTextStyle.copyWith(
                                      color: onPrimaryColor),
                                ),
                                ontap: () {
                                  model.switchState(
                                      EnumToString.convertToString(
                                          Status.Tips));
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              ///Image Avatar
              Positioned(
                top:-height*0.075,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.22),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, top: 4.0, left: 4.0, right:4.0,),
                    child: CustomImage(
                      image: AssetImage('asset/images/Group.png'),
                      ontap: () { },
                      height: height*0.15,
                      width: width*0.22,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget selectRateSheet(ArrivingSelectionViewModel model) {
    final double circleRadius = 120.0;
    String rated = '';
    return DraggableScrollableSheet(
      key: model.rateSheetKey,
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),),
        child: Stack(
            overflow: Overflow.visible,
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: smallPadding.copyWith(bottom: 0),
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                          child: Image(
                            image: AssetImage('asset/icons/ic_gesture.png'),
                          )),
                      Padding(
                        padding: smallPadding.copyWith(right: 0.0, left:0.0, bottom: 0.0,top: 5.h),
                        child: Text(
                          model.driverModel!.driverName ??
                          "Patrick",
                          style: buttonTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              color: onPrimaryColor),
                        ),
                      ),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                              EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: secondaryColor,
                              ),
                              onRatingUpdate: (rating) {
                                rated = model.switchRateLabel(rating);
                              },
                            ),
                            Text(
                              rated,
                              style: heading2.copyWith(
                                  fontWeight: FontWeight.w400),
                            ),
                            Container(
                              height: 5 * 24.0,
                              child: CustomTextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: height * 0.06,
                          width: double.infinity,
                          child: PrimaryButton(
                            text: Text(
                              rate_btn,
                              style: buttonTextStyle.copyWith(
                                  color: onSecondaryColor),
                            ),
                            ontap: () {
                              model.switchState(
                                  EnumToString.convertToString(
                                      Status.Tips));
                            },
                          )),
                    ],
                  ),
                ),
              ),

              ///Image Avatar
              Positioned(
                top:-height*0.075,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.22),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, top: 4.0, left: 4.0, right:4.0,),
                    child: CustomImage(
                      image: AssetImage('asset/images/Group.png'),
                      ontap: () { },
                      height: height*0.15,
                      width: width*0.22,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget selectTipsSheet(ArrivingSelectionViewModel model) {
    final double circleRadius = 120.0;
    return DraggableScrollableSheet(
      key: model.tipsSheetKey,
      expand: true,
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.4,
      builder: (context, scrollController) =>Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),),
        child: Stack(
            overflow: Overflow.visible,
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: smallPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Center(
                          child: Image(
                            image: AssetImage('asset/icons/ic_gesture.png'),
                          )),
                      Padding(
                        padding: smallPadding.copyWith(right: 0.0, left:0.0, bottom: 0.0,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //DRIVER NAME TAG
                            Text(
                              model.driverModel!.driverName ??
                              "Patrick",
                              style: buttonTextStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: onPrimaryColor),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width*0.19,
                            height: height * 0.06,
                            child: PrimaryButton(
                                color: 1 == model.buttonState
                                    ? secondaryColor
                                    : onSecondaryColor,
                                text: Text(
                                  "0%",
                                  style: buttonTextStyle.copyWith(
                                    color: 1 == model.buttonState
                                        ? onSecondaryColor
                                        : onPrimaryColor,
                                  ),
                                ),
                                ontap: () {
                                  model.switchButtonState(1);
                                  //  model.switchButtonState("OneBState");
                                }),
                          ),
                          Container(
                            width: width*0.19,
                            height: height * 0.06,
                            child: PrimaryButton(
                                color: 2 == model.buttonState
                                    ? secondaryColor
                                    : onSecondaryColor,
                                text: Text(
                                  "5%",
                                  style: buttonTextStyle.copyWith(
                                    color: 2 == model.buttonState
                                        ? onSecondaryColor
                                        : onPrimaryColor,
                                  ),
                                ),
                                ontap: () {
                                  model.switchButtonState(2);
                                  //  model.switchButtonState("TwoBState");
                                }),
                          ),
                          Container(
                            width: width*0.19,
                            height: height * 0.06,
                            child: PrimaryButton(
                                color: 3 == model.buttonState
                                    ? secondaryColor
                                    : onSecondaryColor,
                                text: Text(
                                  "10%",
                                  style: buttonTextStyle.copyWith(
                                    color: 3 == model.buttonState
                                        ? onSecondaryColor
                                        : onPrimaryColor,
                                  ),
                                ),
                                ontap: () {
                                  model.switchButtonState(3);
                                  //  model.switchButtonState("ThreeBState");
                                }),
                          ),
                          Container(
                            width: width*0.19,
                            height: height * 0.06,
                            child: PrimaryButton(
                                color: 4 == model.buttonState
                                    ? secondaryColor
                                    : onSecondaryColor,
                                text: Text(
                                  "20%",
                                  style: buttonTextStyle.copyWith(
                                    color: 4 == model.buttonState
                                        ? onSecondaryColor
                                        : onPrimaryColor,
                                  ),
                                ),
                                ontap: () {
                                  model.switchButtonState(4);
                                  // model.switchButtonState("FourBState");
                                }),
                          ),
                        ],
                      ),
                      Text(
                        TipText,
                        style: heading2.copyWith(
                            fontWeight: FontWeight.w400,
                            color: onPrimaryColor),
                      ),
                      Container(
                          width: double.infinity,
                          height: height * 0.06,
                          child: PrimaryButton(
                            text: Text(
                              submit,
                              style: buttonTextStyle.copyWith(
                                  color: onSecondaryColor),
                            ),
                            ontap: () {
                              model.setBusy(true);
                              //Unassign Driver
                              model.unassignDriver();
                              state = '';
                              model.setBusy(false);
                              //Throw to next Page
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new ReceiptView(
                                        requestId: model.requestId,
                                      )));
                              // model.switchState("On Trip");
                            },
                          )),
                    ],
                  ),
                ),
              ),

              ///Image Avatar
              Positioned(
                top:-height*0.075,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.22),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, top: 4.0, left: 4.0, right:4.0,),
                    child: CustomImage(
                      image: AssetImage('asset/images/Group.png'),
                      ontap: () { },
                      height: height*0.15,
                      width: width*0.22,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget _showCancelPanel(
      BuildContext context, ArrivingSelectionViewModel model) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: onSecondaryColor,
          elevation: 0.0,
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              elevation: 4.0,
              fillColor: Colors.white,
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: onPrimaryColor,
                size: 17.0,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ),
          ),
        ),
        backgroundColor: onSecondaryColor,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  width: 220.0,
                  child: Text(
                    cancel_reason,
                    style: boldHeading1.copyWith(color: onPrimaryColor),
                  ),
                ),
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildCheckListItems(index, model);
                  }),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 21.0,
                ),
                width: double.infinity,
                height: 50,
                child: PrimaryButton(
                  text: Text(
                    submit,
                    style: buttonTextStyle,
                  ),
                  ontap: () {
                    model.switchState(
                        EnumToString.convertToString(Status.Cancelled));
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => BookingView()));
                  },
                ),
              ),
            ]),
      ),
    );
  }

  Widget _myRadioButton(
      {required String title,
      required int value,
      Function(int?)? onChanged,
      required ArrivingSelectionViewModel model}) {
    return RadioListTile(
      value: value,
      onChanged: onChanged!,
      title: Text(title),
      groupValue: model.groupValue,
    );
  }

  Widget _buildCheckListItems(int index, ArrivingSelectionViewModel model) {
    return Column(
      //Via List Model
      children: <Widget>[
        _myRadioButton(
            title: cancel_r1,
            value: 0,
            onChanged: (newValue) => model.switchGroupValue(newValue!),
            model: model),
        _myRadioButton(
            title: cancel_r2,
            value: 1,
            onChanged: (newValue) => model.switchGroupValue(newValue!),
            model: model),
        _myRadioButton(
            title: cancel_r3,
            value: 2,
            onChanged: (newValue) => model.switchGroupValue(newValue!),
            model: model),
        _myRadioButton(
            title: cancel_r4,
            value: 3,
            onChanged: (newValue) => model.switchGroupValue(newValue!),
            model: model),
        _myRadioButton(
            title: cancel_r5,
            value: 4,
            onChanged: (newValue) => model.switchGroupValue(newValue!),
            model: model),
      ],
    );
  }
}