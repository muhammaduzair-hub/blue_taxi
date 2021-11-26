
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SplashScreenViewModel extends BaseModel{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final AuthRepository _repo ;
  late Widget nextRoute=Scaffold();

  SplashScreenViewModel({
    required AuthRepository repo,
  }): _repo = repo,super(false){
    _getToken();
    _configureFirebaseListener();
    getALreadySignIn();
  }

  _getToken(){
    _firebaseMessaging.getToken().then((value)  {
      print(" Device Token:$value");
    });
  }

  _configureFirebaseListener(){
    _firebaseMessaging.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      print("TItle====="+event.notification!.title.toString());
      print("Body====="+event.notification!.body.toString());
    });
  }

  void getALreadySignIn() async{
    setBusy(true);
    signedINUser=await _repo.getAlreadySignIn();
    signedINUser.id!=''
        ? nextRoute=BookingView()
        :nextRoute=SignInSignUpView();
    setBusy(false);
  }
}