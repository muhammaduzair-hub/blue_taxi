import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';

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
                  builder: (context) => new SignInSignUpView())
              );
            },
            child: const Text('VerifyCode(Not linked)'),
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
            child: const Text('Profile(Not linked)'),
          ),
        ]
      ),
    );
  }
}
