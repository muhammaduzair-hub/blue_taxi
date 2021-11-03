import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class SignInSignUpViewModel extends BaseModel{
  final AuthRepository _repo ;

  SignInSignUpViewModel({
    @required AuthRepository repo
  }): _repo = repo;


  Future<bool> login({String name, String email, String pass}) async {
    setBusy(true);
    await Future.delayed(Duration(seconds: 1));
    bool success = true;
    setBusy(false);
    return success;
  }

  bool validateMobileNumber(String value) {
    setBusy(true);
    bool ans;
    String pattern = r"^(?:(\+92\d{10})|(\d{11}))$";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      ans= false;
    }
    else if (!regExp.hasMatch(value)) {
      ans= false;
    }
    else ans =  true;
    setBusy(false);
    return ans;
  }

  bool validateEmail(String value) {
    setBusy(true);
    bool ans = EmailValidator.validate(value);
    setBusy(false);
    return ans;
  }

  bool validateName(String value){
    setBusy(true);

    bool ans;
    String pattern = r'^[a-zA-Z][a-zA-Z\s]+[a-zA-Z]$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      ans= false;
    }
    else if (!regExp.hasMatch(value)) {
      ans= false;
    }
    else ans =  true;

    setBusy(false);
    return ans;
  }

  bool validatePassword(String value){
    setBusy(true);
    bool ans;
    String pattern = r'^(?=.*[A-Za-z])(?=.*\d)\S{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      ans= false;
    }
    else if (!regExp.hasMatch(value)) {
      ans= false;
    }
    else ans =  true;
    setBusy(false);
    return ans;
  }

}