

import 'dart:async';

import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/remote/api.dart';

class AuthRepository{
  final Api _api;

  AuthRepository({required Api api}):_api= api;
  
  StreamController<UserModel> _userController = StreamController<UserModel>();
  Stream<UserModel> get user => _userController.stream;


// Signup Without Frebase Auth
  Future signUpWithEmailAndPassword(String name,String email,String phoneNo, password) async {

    dynamic result = await _api.signUpWithEmailPassword(name, email,phoneNo, password);
    if(result == null) {
      print("Not SignedUp");
    }
    return result;
  }


  // Signup Without Frebase Auth
  Future signInWithEmailAndPassword(String phoneNo, String password) async {

    dynamic result = await _api.signInWithEmailPassword(phoneNo, password);
    if(result.toString() == false) {
      print("Not SignedIn By AuthRepo");
    }
    print("Result BY Repo Class"+result.toString());
    return result;
  }


}