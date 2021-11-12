import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class MyProfileViewModel extends BaseModel{

  final AuthRepository _repo ;

  //variabels who are going to communicate with UI
  bool switchState=false;

  MyProfileViewModel({
    required AuthRepository repo
  }): _repo = repo,super(false);

  void changeSwitchState(){
    setBusy(true);
    switchState = !switchState;
    setBusy(false);
  }

}