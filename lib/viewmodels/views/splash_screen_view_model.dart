
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

class SplashScreenViewModel extends BaseModel{

  final AuthRepository _repo ;
  late Widget nextRoute=Scaffold();

  SplashScreenViewModel({
    required AuthRepository repo,
  }): _repo = repo,super(false){
    getALreadySignIn();
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