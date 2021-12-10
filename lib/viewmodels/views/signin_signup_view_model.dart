
import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../base_model.dart';


class SignInSignUpViewModel extends BaseModel {

  late final AuthRepository _repo ;
  late UserModel signedIdnUser ;

  bool nameState=true;
  bool passState=true;
  bool emailState=true;
  bool phoneState=true;
  bool error=false;
  bool duplicateEmail=false;
  bool duplicatePhone=false;





  SignInSignUpViewModel({
    required AuthRepository repo,
  }) : super(false){
    _repo = repo;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  bool validateMobileNumber(String value) {
    bool ans;
    String pattern = r"^(?:(\+92\d{10})|(\d{11}))$";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      ans= false;
      phoneState=false;
    }
    else if (!regExp.hasMatch(value)) {
      ans= false;
      phoneState=false;
    }
    else {
      ans = true;
      phoneState=true;
    }
    setBusy(false);
    return ans;
  }

   validateEmail(String value, String phoneNo) async {
    //method to check if this email is already existing
    bool ans = EmailValidator.validate(value);
    emailState=ans;
    if(ans) {
      var anss=  await _repo.validateEmail(value);
      if(anss==false) {
        {
          ans=anss;
          duplicateEmail = true;
        }
      } else {
        ans = anss;
        emailState = ans;
        if (ans && phoneState) {
          var ano = await _repo.validatePhone(phoneNo);
          if(ano){
            ans=ano;
            phoneState = ano;
            duplicatePhone=false;
          }
          else{
            ans = ano; //ano is false
            phoneState = ano;
            duplicatePhone = true;
          }
        }
      }
    }
    setBusy(false);
    return ans;
  }

  bool validateName(String value){
    bool ans;
    String pattern = r'^[a-zA-Z][a-zA-Z\s]+[a-zA-Z]$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      ans= false;
      nameState=false;
    }
    else if (!regExp.hasMatch(value)) {
      nameState=false;
      ans= false;
    }
    else {
      nameState=true;
      ans = true;
    }

    setBusy(false);
    return ans;
  }

  bool validatePassword(String value){
    bool ans;
    String pattern = r'^(?=.*[A-Za-z])(?=.*\d)\S{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      passState=false;
      ans= false;
    }
    else if (!regExp.hasMatch(value)) {
      ans= false;
      passState=false;

    }
    else {
      ans =  true;
    passState=true;
    }
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