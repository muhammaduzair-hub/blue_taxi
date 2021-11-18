

import 'dart:async';

import 'package:bluetaxiapp/data/local/local_api.dart';
import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/remote/api.dart';
import 'package:bluetaxiapp/data/remote/firebase_directory/firebase.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthRepository{
  final Api api;
  final LocalApi localApi;

  AuthRepository({required Api api,required LocalApi localApi,}):api= api,localApi=localApi;
  
  StreamController<UserModel> _userController = StreamController<UserModel>();
  Stream<UserModel> get user => _userController.stream;

  Future<bool> test() async {
    bool res =  await localApi.test();
    return res;
  }

// Signup Without Firebase Auth
  Future signUpWithEmailAndPassword(String name,String email,String phoneNo, password) async {

    dynamic result = await api.signUpWithEmailPassword(name, email,phoneNo, password);
    if(result == null) {
      print("Not SignedUp");
    }
    return result;
  }

  Future<DriverModel?> getRequestData(String uid) async {
    Future<DriverModel?> result= api.getRequestData(uid);
    return result;
  }

  // Signup Without Firebase Auth
  Future signInWithEmailAndPassword(String phoneNo, String password) async {
    UserModel result = await api.signInWithEmailPassword(phoneNo, password);
    // if(result.id!=""){
    //   await localApi.addLoginPerson(result);
    // }
    return result;
  }

  Future addAdressLocally({required String adress}) async{
    dynamic result = await localApi.addAdress(title: adress);
    return result;
  }

  Future getAdressLocally() async{
    return await localApi.readAllAdresses();
  }

  Future getVehiclesLocally() async{
    return await localApi.vehicalList;
  }

  Future generateRequest({
    required String userToken,
    required String carType,
    required String expectedBill,}) async
  {
    dynamic res = await api.generateRequest(userToken: userToken, carType: carType, expectedBill: expectedBill);
    return res;
  }

  Future<UserModel> getAlreadySignIn() async{
    UserModel person = await localApi.getAlreadySignIn();
    return person;
  }

  void unassignDriver() {
    api.unassignDriver();
  }

  Future addCard({required String cardNumber, required String cardHolder, required int expMonth, required int expYear})async{
    dynamic ans = await api.addCard(cardNumber: cardNumber, cardHolder: cardHolder, expMonth: expMonth, expYear: expYear);
    return ans;
  }

  void switchToCompletedState(String requestId) {
    api.switchToCompletedState(requestId);
  }

  void switchToCancelledState(String requestId) {
    api.switchToCancelledState(requestId);
  }

  void switchToDispatchedState(String requestId) {
    api.switchToDispatchedState(requestId);
  }

  validateEmail(String value, String phoneNo) async {
    Future<bool> result = api.validateEmail(email: value,phoneNo: phoneNo);
    return result;
  }
}