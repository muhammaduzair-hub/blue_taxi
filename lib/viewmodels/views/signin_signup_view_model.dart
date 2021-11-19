
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/ui/views/verify_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class SignInSignUpViewModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;
  late final AuthRepository _repo ;
  late UserModel signedIdnUser ;


  SignInSignUpViewModel({
    required AuthRepository repo,
  }){
    _repo = repo;
  }



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

  bool validateEmail(String value, String phoneNo) {
    setBusy(true);
    //method to check if this email is already existing

    bool ans = EmailValidator.validate(value);
    if(ans) ans= _repo.validateEmail(value,phoneNo);
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
    signedIdnUser = await _repo.signInWithEmailAndPassword(phoneNoController.text, passwordController.text);
    signedINUser = signedIdnUser; //this is global variable
    print(signedIdnUser.id);
    _repo.localApi.addLoginPerson(signedIdnUser);
    setBusy(false);
  }//End Signin Function


}