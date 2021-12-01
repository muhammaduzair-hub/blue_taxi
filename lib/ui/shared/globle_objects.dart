import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:enum_to_string/enum_to_string.dart';

late UserModel signedINUser;
late String requestId='';
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