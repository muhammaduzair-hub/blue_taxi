import 'dart:async';

import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/cancellation_reason_view.dart';
import 'package:bluetaxiapp/ui/views/message_view.dart';
import 'package:bluetaxiapp/ui/views/receipt_view.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:bluetaxiapp/ui/widgets/custom_text_field.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
import 'package:bluetaxiapp/viewmodels/views/arriving_view_model.dart';
import 'package:bluetaxiapp/ui/views/dialPad_View.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ArrivingScreen extends StatelessWidget {

  String requestedId;

  ArrivingScreen({Key? key, required this.requestedId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ArrivingSelectionViewModel>(
        model: ArrivingSelectionViewModel(requestedId, repo: Provider.of(context)),
        builder: (context, model, child) => SafeArea(
            child: model.busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Scaffold(
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
                    // Change Navigation Button on Model State
                    // if (model.busy)
                    //   CircularProgressIndicator()
                    // else
                      if (state == EnumToString.convertToString(Status.Active) ||
                        state == EnumToString.convertToString(Status.Completed) ||
                        state == EnumToString.convertToString(Status.Rate))
                      LeadingBackButton(
                        radius: 30.0,
                        ontap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new UserMenuView()));
                        },
                        icon: AssetImage('asset/icons/nav_btn.png'),
                      ),


                    //Chnage Header Text on Model State
                      if (state == EnumToString.convertToString(Status.Active))
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            LabelArriving,
                            style: boldHeading1.copyWith(color: onPrimaryColor),
                          ),
                        ),
                      )
                    else if (state == EnumToString.convertToString(Status.Completed))
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            LabelOnTrip,
                            style: boldHeading1.copyWith(color: onPrimaryColor),
                          ),
                        ),
                      )
                    else if (state == EnumToString.convertToString(Status.Rate))
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "sendFeedback",
                            style: boldHeading1.copyWith(color: onPrimaryColor),
                          ),
                        ),
                      ),

                    //Chnage Bottom sheets on Model State
                    if (state == EnumToString.convertToString(Status.Booked))
                      selectDriverSearchingSheet(model, context) //Checked
                    else if (state == EnumToString.convertToString(Status.Active))
                      selectArrivingBottomSheet(model) //Checked
                    else if (state == EnumToString.convertToString(Status.Dispatched))
                      selectArrivedBottomSheet(model, context) //Checked
                     else if (state == EnumToString.convertToString(Status.OnGoing))
                       selectDisbaledArrivingBottomSheet(model) //Checked
                    else if (state == EnumToString.convertToString(Status.Completed))
                      selectTipAndRateSheet(model) //Checked
                    else if (state == EnumToString.convertToString(Status.Tips))
                      selectTipsSheet(model)
                    else if (state == EnumToString.convertToString(Status.Rate))
                      selectRateSheet(model),
                  ]))));
  }
  //Booked
  Widget selectDriverSearchingSheet(
      ArrivingSelectionViewModel model, BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Future<DriverModel?> driver = model.checkDriver();
    });
    //selectArrivingBottomSheetEnds
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black26.withOpacity(0.8),
        // Aligns the container to center
        child: Column(
          children: [
            //Cancel Reason Button
            Align(
              alignment: Alignment.topLeft,
              child: LeadingBackButton(
                radius: 30.0,
                ontap: () {
                  //model.switchState(EnumToString.convertToString(Status.Cancelled));
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new CancellationReasonView()));
                },
                icon: AssetImage('asset/icons/btn_cancel.png'),
              ),
            ),
            UIHelper.verticalSpaceLarge,

            //Copied Code for Ripple
            Container(
              child: Stack(alignment: Alignment(0, 0), children: <Widget>[
                Center(
                  //Load a Lottie file from your assets
                  child: Lottie.asset('asset/images/ripple_effect.json'),
                ),
                Positioned(
                  child: Container(
                    height: 60.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                        color: onSecondaryColor,
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

            UIHelper.verticalSpaceLarge,

            //Searching Driver Text
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Searching For Driver",
                  style: boldHeading1.copyWith(color: onSecondaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Active
  Widget selectArrivingBottomSheet(ArrivingSelectionViewModel model) {
    final double circleRadius = 120.0;
    // String driverId = FirebaseFirestore.instance
    //     .collection('request')
    //     .where('userId', isEqualTo: signedINUser.id)
    //     .snapshots();

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) => ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.transparent,
          child: Stack(children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: circleRadius / 2.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Center(
                              child: Image(
                            image: AssetImage('asset/icons/ic_gesture.png'),
                          )),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  model.driverModel!.driverName ?? "Patrick",
                                  style: buttonTextStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: onPrimaryColor),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: secondaryColor2,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'HS785K',
                                      style: buttonTextStyle.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: onPrimaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Volkswagen Jetta',
                            style: heading2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: onPrimaryColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NavButton(
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
                                      NavButton(
                                        ontap: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      new MessageView()));
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
                              NavButton(
                                ontap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => new CancellationReasonView()));
                                  //model.switchState(EnumToString.convertToString(Status.Cancelled));
                                },
                                icon: AssetImage('asset/icons/btn_cancel.png'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///Image Avatar
                Container(
                  width: circleRadius,
                  height: circleRadius,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Center(
                      child: Container(
                        child:
                            Image(image: AssetImage('asset/images/Group.png')),

                        /// replace your image with the Icon
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  //Dispatched
  Widget selectArrivedBottomSheet(
      ArrivingSelectionViewModel model, BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black26.withOpacity(0.8),
        // Aligns the container to center
        child: Column(
          children: [
            //Cancel Reason Button
            Align(
              alignment: Alignment.topLeft,
              child: LeadingBackButton(
                radius: 30.0,
                ontap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new UserMenuView()));
                },
                icon: AssetImage('asset/icons/nav_btn.png'),
              ),
            ),
            UIHelper.verticalSpaceLarge,

            //Copied Code for Ripple
            Container(
              child: Stack(alignment: Alignment(0, 0), children: <Widget>[
                Positioned(
                  child: Container(
                    height: 380.0,
                    width: 333.0,
                    decoration: BoxDecoration(
                        color: onSecondaryColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image(
                                    image:
                                    AssetImage('asset/images/car_top.png')),
                                Text(
                                  "Your Taxi has Arrived",
                                  style: buttonTextStyle.copyWith(
                                      fontWeight: FontWeight.w700),
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: PrimaryButton(
                                      text: Text(
                                        "${model.driverModel!.driverName ?? "Patrick"} is Coming",
                                        style: buttonTextStyle.copyWith(
                                            color: onSecondaryColor),
                                      ),
                                      ontap: () {
                                        model.switchState(EnumToString.convertToString(Status.OnGoing));
                                      },
                                    )),
                              ],
                            ),
                          )),
                    ),
                  ),
                )
              ]),
            ),

            UIHelper.verticalSpaceLarge,
          ],
        ),
      ),
    );
  }

  //OnGoing
  Widget selectDisbaledArrivingBottomSheet(ArrivingSelectionViewModel model) {
    final double circleRadius = 120.0;
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) => ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.transparent,
          child: Stack(children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: circleRadius / 2.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Center(
                              child: Image(
                                image: AssetImage('asset/icons/ic_gesture.png'),
                              )),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  model.driverModel!.driverName ?? "Patrick",
                                  style: buttonTextStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: onPrimaryColor),
                                ),
                                Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: secondaryColor2,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'HS785K',
                                      style: buttonTextStyle.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: onPrimaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Volkswagen Jetta',
                            style: heading2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: onPrimaryColor),
                          ),
                          Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                model.switchToCompletedState();
                                model.switchState(EnumToString.convertToString(Status.Completed));
                                await Future.delayed(Duration(seconds: 20));
                                model.unassignDriver();
                                },
                              child: const Text('Enjoy Your Ride'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///Image Avatar
                Container(
                  width: circleRadius,
                  height: circleRadius,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Center(
                      child: Container(
                        child:
                        Image(image: AssetImage('asset/images/Group.png')),

                        /// replace your image with the Icon
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  //Completed
  Widget selectTipAndRateSheet(ArrivingSelectionViewModel model) {
    final double circleRadius = 120.0;
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) => ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.transparent,
          child: Stack(children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: circleRadius / 2.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Center(
                              child: Image(
                            image: AssetImage('asset/icons/ic_gesture.png'),
                          )),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  model.driverModel!.driverName ?? "Patrick",
                                  style: buttonTextStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: onPrimaryColor),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: secondaryColor2,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'HS785K',
                                      style: buttonTextStyle.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: onPrimaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Volkswagen Jetta',
                            style: heading2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: onPrimaryColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 159,
                                height: 50,
                                child: PrimaryButton(
                                    text: Text(
                                      rate_btn,
                                      style: buttonTextStyle,
                                    ),
                                    ontap: () {
                                      //switchState
                                      model.switchState(EnumToString.convertToString(Status.Rate));
                                    }),
                              ),
                              Container(
                                width: 159,
                                height: 50,
                                child: PrimaryButton(
                                    color: onSecondaryColor,
                                    text: Text(
                                      tips_btn,
                                      style: buttonTextStyle.copyWith(
                                          color: onPrimaryColor),
                                    ),
                                    ontap: () {
                                      model.switchState(EnumToString.convertToString(Status.Tips));
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///Image Avatar
                Container(
                  width: circleRadius,
                  height: circleRadius,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Center(
                      child: Container(
                        child:
                            Image(image: AssetImage('asset/images/Group.png')),

                        /// replace your image with the Icon
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
  Widget selectRateSheet(ArrivingSelectionViewModel model) {
    final double circleRadius = 120.0;
    String rated = "Excellent";
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) => ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Container(
          color: Colors.transparent,
          child: Stack(children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: circleRadius / 2.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: onSecondaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Image(
                                  image: AssetImage('asset/icons/ic_gesture.png'),
                                )),
                          ),
                          UIHelper.verticalSpaceSmall,
                          Text(
                            model.driverModel!.driverName!,
                            style: buttonTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: onPrimaryColor),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RatingBar.builder(
                                  initialRating: 3,
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
                                CustomTextField(
                                  maxLines: 3,
                                  minLines: 3,
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              height: 50,
                              child: PrimaryButton(
                                text: Text(
                                  rate_btn,
                                  style: buttonTextStyle.copyWith(
                                      color: onSecondaryColor),
                                ),
                                ontap: () {
                                  model.switchState(EnumToString.convertToString(Status.Tips));
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ),

                ///Image Avatar
                Container(
                  width: circleRadius,
                  height: circleRadius,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Center(
                      child: Container(
                        child:
                        Image(image: AssetImage('asset/images/Group.png')),

                        /// replace your image with the Icon
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
  Widget selectTipsSheet(ArrivingSelectionViewModel model) {
    final double circleRadius = 120.0;
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) => ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Container(
          color: Colors.transparent,
          child: Stack(children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: circleRadius / 2.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: onSecondaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Image(
                                  image: AssetImage('asset/icons/ic_gesture.png'),
                                )),
                          ),
                          SizedBox(height: 40.0),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  model.driverModel!.driverName ?? "Patrick",
                                  style: buttonTextStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: onPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpaceMedium,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 79,
                                height: 50,
                                child: PrimaryButton(
                                  color: 1==model.buttonState? secondaryColor : onSecondaryColor,
                                    text: Text(
                                      "0%",
                                      style: buttonTextStyle.copyWith(
                                        color: 1==model.buttonState? onSecondaryColor : onPrimaryColor,
                                      ),
                                    ),
                                    ontap: () {
                                    model.switchButtonState(1);
                                    //  model.switchButtonState("OneBState");
                                    }),
                              ),
                              Container(
                                width: 79,
                                height: 50,
                                child: PrimaryButton(
                                    color: 2==model.buttonState?secondaryColor : onSecondaryColor,
                                    text: Text(
                                      "5%",
                                      style: buttonTextStyle.copyWith(
                                        color: 2==model.buttonState? onSecondaryColor : onPrimaryColor,
                                      ),
                                    ),
                                    ontap: () {
                                      model.switchButtonState(2);
                                    //  model.switchButtonState("TwoBState");
                                    }),
                              ),
                              Container(
                                width: 79,
                                height: 50,
                                child: PrimaryButton(
                                    color: 3==model.buttonState? secondaryColor : onSecondaryColor,
                                    text: Text(
                                      "10%",
                                      style: buttonTextStyle.copyWith(
                                        color: 3==model.buttonState? onSecondaryColor : onPrimaryColor,
                                      ),
                                    ),
                                    ontap: () {
                                      model.switchButtonState(3);
                                      //  model.switchButtonState("ThreeBState");
                                    }),
                              ),
                              Container(
                                width: 79,
                                height: 50,
                                child: PrimaryButton(
                                    color: 4==model.buttonState? secondaryColor : onSecondaryColor,
                                    text: Text(
                                      "20%",
                                      style: buttonTextStyle.copyWith(
                                          color: 4==model.buttonState? onSecondaryColor : onPrimaryColor,
                                      ),
                                    ),
                                    ontap: () {
                                      model.switchButtonState(4);
                                      // model.switchButtonState("FourBState");
                                    }),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpaceSmall,
                          Text(
                            TipText,
                            style: heading2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: onPrimaryColor),
                          ),
                          UIHelper.verticalSpaceMedium,
                          Container(
                              width: double.infinity,
                              height: 50,
                              child: PrimaryButton(
                                text: Text(
                                  submit,
                                  style: buttonTextStyle.copyWith(
                                      color: onSecondaryColor),
                                ),
                                ontap: () {
                                  //Unassign Driver
                                  model.unassignDriver();
                                  state = '';
                                  model.setBusy(false);
                                  //Throw to next Page
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                          new ReceiptView(requestId: model.requestId,)));
                                  // model.switchState("On Trip");
                                },
                              )),
                          UIHelper.verticalSpaceSmall,
                        ],
                      ),
                    ),
                  ),
                ),

                ///Image Avatar
                Container(
                  width: circleRadius,
                  height: circleRadius,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Center(
                      child: Container(
                        child:
                        Image(image: AssetImage('asset/images/Group.png')),

                        /// replace your image with the Icon
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

}