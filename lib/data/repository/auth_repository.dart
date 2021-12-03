

import 'dart:async';

import 'package:bluetaxiapp/data/local/local_api.dart';
import 'package:bluetaxiapp/data/model/card_model.dart';
import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/data/model/adress_model.dart';
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/remote/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as con;

class AuthRepository {
  final Api api;
  final LocalApi localApi;

  AuthRepository({required Api api,required LocalApi localApi,}):api= api,localApi=localApi;
  
  StreamController<UserModel> _userController = StreamController<UserModel>();
  Stream<UserModel> get user => _userController.stream;

  Future<bool> test() async {
    bool res = await localApi.test();
    return res;
  }

// Signup Without Firebase Auth
  Future signUpWithEmailAndPassword(String name, String email, String phoneNo,
      password) async {
    dynamic result = await api.signUpWithEmailPassword(
        name, email, phoneNo, password);
    if (result == null) {
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
    late List<AdressModel> result;
    result = await api.getAddress(adress);
    result = result.where((element) => element.adressTitle.contains(adress)).toList();
    if(result.isNotEmpty)
    {
      await localApi.addAdress(adressModel: result.first);
      return localApi.readAllAdresses();
    }
    return;
  }

  Future getAdressRemote({required String adress}) async{
    late List<AdressModel> result;
    result = await api.getAddress(adress);
    result = result.where((element) => element.adressTitle.contains(adress)).toList();
    if(result.isNotEmpty)
      {
        return result;
      }
    else{
      String url = 'http://api.positionstack.com/v1/forward?access_key=628ca0078b787fa83e11e4e06b35cc8d&query= $adress';
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        UrlDataModel model = UrlDataModel.fromJson(con.jsonDecode(response.body));

        model.address.removeWhere((element) => element.country!='Pakistan');
        model.address.forEach((element) async{await api.saveAddress(element);});

        var res = await api.firestoreAdresses.get();
        result =await res.docs.map((e) => AdressModel.fromJson(e.data())).toList();
        result = result.where((element) => element.adressTitle.contains(adress)).toList();
        return result;
      }
      else {
        print(response.body);
      }
      return;
    }
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
    required String expectedBill,
    required AdressModel toAdress,
    required AdressModel fromAdress,
    required CardModel card,
    required double bill
  }) async
  {
    dynamic res = await api.generateRequest(
      userToken: userToken,
      carType: carType,
      expectedBill: expectedBill,
      toAdress: toAdress,
      fromAdress: fromAdress,
      card: card,
      bill: bill
    );
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

  void switchToOnGoingState(String requestId) {
    api.switchToOnGoingState(requestId);
  }

  validateEmail(String value,) async {
    dynamic result = await api.validateEmail(email: value);
    print('Result in Auth $result');
    return result;
  }

  Future<DriverModel> getDriver(String driverId) async {
    DriverModel driverDocument = await api.getDriver(driverId);
    return driverDocument;
  }

  validatePhone(String phoneNo) async {
    dynamic result = await api.validatePhone(phoneNo);
    return result;
  }

  getDriverDetails() async {
    DriverModel driverDocument =await api.getDriverDetails();
    return driverDocument;
  }
}