
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

class SplashScreenViewModel extends BaseModel{

  final AuthRepository _repo ;
  final BuildContext context;

  SplashScreenViewModel({
    required AuthRepository repo,
    required BuildContext con
  }): _repo = repo,context=con,super(false){
    getALreadySignIn();
  }


  void getALreadySignIn() async{
    setBusy(true);
    signedINUser=await _repo.getAlreadySignIn();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
            signedINUser.id!=''
                ? BookingView(signInUser: signedINUser)
                :SignInSignUpView(),
          )
      );
    setBusy(false);
  }
}