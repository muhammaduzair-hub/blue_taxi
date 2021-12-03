import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

late UserModel signedINUser;
late String? requestId;
late String state=EnumToString.convertToString(Status.Booked);



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