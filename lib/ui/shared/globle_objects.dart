
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

late UserModel signedINUser;
late String? requestId=null;
late String state='';
bool activeState=false;
bool driverState=true;

//DEVICE HEIGHT WIDTH
late double width;
late double heightWithAppBar;
late double height;


//PADDING
late  EdgeInsets smallPadding;
late  EdgeInsets mediumPadding;
late  EdgeInsets largePadding;

enum Status {
  Booked, //Searching
  Active, //Arriving
  Dispatched, //Arrived
  OnGoing, //
  Completed,
  Rate,
  Tips,
  Cancelled,
}

void showToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0
  );
}