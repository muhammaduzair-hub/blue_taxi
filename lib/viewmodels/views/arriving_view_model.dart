import 'dart:async';
import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:enum_to_string/enum_to_string.dart';

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


class ArrivingSelectionViewModel extends BaseModel {
  final AuthRepository repo;
  late String state;
  late Future<DriverModel?> driver;
  final String requestId;
  late int buttonState=1;



  ArrivingSelectionViewModel({required this.requestId, required this.repo}) : super(false) {
    state = EnumToString.convertToString(Status.Booked);

    print(state);
    driver = getRequest(requestId);
    print(driver);
  }

  @override
  dispose(){
  }

  switchState(String newstate) async {
    setBusy(true);
    state = newstate;
    if(state == EnumToString.convertToString(Status.Active)) {
     // startTimer
    await Future.delayed(Duration(seconds: 8));
     if(state !=  EnumToString.convertToString(Status.Cancelled)){
       switchState(EnumToString.convertToString(Status.Dispatched));
       switchToDispatchedState();
     }
    }

    if(state == EnumToString.convertToString(Status.Cancelled)){
      unassignDriver();
      switchToCancelledState();
    }
    setBusy(false);
  }


  Future<DriverModel?> checkDriver() async {
    setBusy(true);
    if(driver!=null)switchState(EnumToString.convertToString(Status.Active));
    setBusy(false);
    return driver;
  }

  String switchRateLabel(double rating) {
    String rated = "Excellent";
    setBusy(true);

    if (rating == 1.0)
      rated = "Very Bad";
    else if (rating == 2.0)
      rated = "Bad";
    else if (rating == 3.0)
      rated = "Good";
    else if (rating == 4.0)
      rated = "Very Good";
    else if (rating == 5.0)
      rated = "Excellent";
    setBusy(false);
    return rated;
  }

  Future<DriverModel?> getRequest(String uid) async {
    dynamic result= repo.getRequestData(uid);
    return result;
  }

  void unassignDriver() {
    repo.unassignDriver();
  }

  void switchToCompletedState() {
    repo.switchToCompletedState(requestId);
  }
  void switchToDispatchedState() {
    repo.switchToDispatchedState(requestId);
  }

  void switchToCancelledState() {
    repo.switchToCancelledState(requestId);
  }

  switchButtonState(int state){
    buttonState=state;
    setBusy(false);
  }


}