

import 'dart:async';

import 'package:bluetaxiapp/data/local/local_api.dart';
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/remote/api.dart';
import 'package:bluetaxiapp/data/remote/firebase_directory/firebase.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthRepository{
  final Api _api;
  final LocalApi _localApi;

  AuthRepository({required Api api,required LocalApi localApi,}):_api= api,_localApi=localApi;
  
  StreamController<UserModel> _userController = StreamController<UserModel>();
  Stream<UserModel> get user => _userController.stream;


// Signup Without Firebase Auth
  Future signUpWithEmailAndPassword(String name,String email,String phoneNo, password) async {

    dynamic result = await _api.signUpWithEmailPassword(name, email,phoneNo, password);
    if(result == null) {
      print("Not SignedUp");
    }
    return result;
  }


  // Signup Without Firebase Auth
  Future signInWithEmailAndPassword(String phoneNo, String password) async {
    dynamic result = await _api.signInWithEmailPassword(phoneNo, password);
    return result;
  }

  Future addAdressLocally({required String adress}) async{
    dynamic result = await _localApi.addAdress(title: adress);
    return result;
  }

  Future getAdressLocally() async{
    return await _localApi.readAllAdresses();
  }

  Future getVehiclesLocally() async{
    return await _localApi.vehicalList;
  }

  Future generateRequest({
    required String userToken,
    required String carType,
    required String expectedBill,}) async
  {
    dynamic res = await _api.generateRequest(userToken: userToken, carType: carType, expectedBill: expectedBill);
    return res;
  }

}