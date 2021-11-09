import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/adress_selection_view.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/ui/views/cancellation_reason_view.dart';
import 'package:bluetaxiapp/ui/views/driver_detail_view.dart';
import 'package:bluetaxiapp/ui/views/my_profile_view.dart';
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:bluetaxiapp/ui/views/terms_conitions_view.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:bluetaxiapp/ui/views/verify_code.dart';

import 'package:flutter/material.dart';

class DevScreenView extends StatelessWidget {
  DevScreenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: onSecondaryColor,
      body:Column(
        children:<Widget>[
          UIHelper.verticalSpaceXLarge,
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => new AdressSelectionView())
              );
            },
            child: const Text('Adress Selection View'),
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
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => new DriverDetailView())
              );
            },
            child: const Text('Driver Detail View'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => new SignInSignUpView())
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
                  builder: (context) => new VerifyCodeView())
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
                  builder: (context) => new CancellationReasonView())
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
        ]
      ),
    );
  }
}
