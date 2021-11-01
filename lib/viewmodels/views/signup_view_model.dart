


import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';

class SignUpViewModel extends BaseModel{
  final AuthRepository _repo ;

  SignUpViewModel({
    @required AuthRepository repo
  }): _repo = repo;

  Future<bool> login({String name, String email, String pass}) async {
    setBusy(true);
    await Future.delayed(Duration(seconds: 1));
    bool success = true;
    setBusy(false);
    return success;
  }
}