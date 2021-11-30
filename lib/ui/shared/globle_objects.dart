import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

late UserModel signedINUser;
late String requestId;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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