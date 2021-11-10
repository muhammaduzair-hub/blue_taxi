import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class SignInSignUpViewModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;
  late final AuthRepository _repo ;
  var firestoreDb = FirebaseFirestore.instance.collection("users").snapshots();


  SignInSignUpViewModel({
    required AuthRepository repo
  }){ _repo = repo;}


  @override
  void dispose() {
    // TODO: implement dispose
    //super.dispose();
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }


  Future<bool> login({required String name, String? email, required String pass}) async {
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


// Signup Without Frebase Auth
  Future<void> signUp(TextEditingController nameController, TextEditingController emailController,TextEditingController phoneNoController, TextEditingController passwordController) async {
    setBusy(true);
    dynamic result = await _repo.signUpWithEmailAndPassword(nameController.text, emailController.text,phoneNoController.text, passwordController.text);
    if(result == null) {
      setBusy(false);
      print("Not SignedUp");
    }
    return result;
    }

  // //Signup Using Firebase Auth
  // Future<void> signup(TextEditingController nameController, TextEditingController emailController,TextEditingController phoneNoController, TextEditingController passwordController) async {
  //   setBusy(true);
  //   dynamic result = await _auth.registerWithEmailAndPassword(nameController.text, emailController.text,phoneNoController.text, passwordController.text);
  //      if(result == null) {
  //        setBusy(false);
  //        print("Not SignedUp");
  //      }
  //      return result;
  // }



//Signin Without Firebase Auth
  Future signin( TextEditingController phoneNoController, TextEditingController passwordController) async {
    setBusy(true);
    bool result = await _repo.signInWithEmailAndPassword(phoneNoController.text, passwordController.text);
    if(result.toString() == false) {
      setBusy(false);
      print("Not SignedIn");
    }
    print("Result BY Model Class"+result.toString());
    return result;
  }//End Signin Function


}