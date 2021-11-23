import 'package:bluetaxiapp/data/local/local_api.dart';
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/services/pushNotificationServices.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/arriving_screen_view.dart';
import 'package:bluetaxiapp/ui/views/adress_selection_view.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/ui/views/cancellation_reason_view.dart';
import 'package:bluetaxiapp/ui/views/driver_detail_view.dart';
import 'package:bluetaxiapp/ui/views/message_view.dart';
import 'package:bluetaxiapp/ui/views/my_profile_view.dart';
import 'package:bluetaxiapp/ui/views/receipt_view.dart';
import 'package:bluetaxiapp/ui/views/splash_screen_view.dart';
import 'package:bluetaxiapp/ui/views/terms_conitions_view.dart';
import 'package:bluetaxiapp/ui/views/trip_history_view.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:bluetaxiapp/ui/views/verify_code.dart';
import 'package:bluetaxiapp/ui/views/dialPad_View.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class DevScreenView extends StatelessWidget {
  DevScreenView({Key? key}) : super(key: key);
  late LocalApi _localApi;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: onSecondaryColor,
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children:<Widget>[
            UIHelper.verticalSpaceXLarge,
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => AdressSelectionView()));
              },
              child: const Text('Adress Selection View'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => RideHistoryView()));
              },
              child: const Text('Trip History View'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new BookingView())
                );
              },
              child: const Text('Booking View'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new MyProfileView())
                );
              },
              child: const Text('My Profile View'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                // Navigator.push(context, new MaterialPageRoute(
                //     builder: (context) => new DriverDetailView())
                // );
              },
              child: const Text('Driver Detail View'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new MySplashScreenView())
                );
              },
              child: const Text('Signin Signup'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new UserMenuView())
                );
              },
              child: const Text('Menu'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new VerifyCodeView(signInUser: UserModel(id: ''),))
                );
              },
              child: const Text('VerifyCode'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new CancellationReasonView(key: null,))
                );
              },
              child: const Text('CancellationReason'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new TermsConditionView())
                );
              },
              child: const Text('Terms&Condition'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () async {

               // dynamic requesty =await  model.getRequest("RTW048yQFu98nbzwfa6q");
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new ArrivingScreen(requestedId: 'LZoVUvFa31fk0Jsb0evm',))
                );
              },
              child: const Text('Arriving View'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new DialPadView())
                );
              },
              child: const Text('Dialpad View'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new MessageView())
                );
              },
              child: const Text('Message View'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new ReceiptView())
                );
              },
              child: const Text('Reciept View'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new NotificationScreen())
                );
              },
              child: const Text('Notification View'),
            ),

          ]
        ),
    ));
  }
}
