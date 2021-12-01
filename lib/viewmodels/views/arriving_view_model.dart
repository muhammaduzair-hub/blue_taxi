import 'dart:async';
import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:enum_to_string/enum_to_string.dart';



class ArrivingSelectionViewModel extends BaseModel {
  final AuthRepository repo;
  late Future<DriverModel?> driver;
  final String requestId;
  late int buttonState=1;
  late int groupValue= -1;
  DriverModel? driverModel;

  ArrivingSelectionViewModel(this.requestId, {required this.repo}) : super(false) {
    driver = getRequest(requestId);
    state= EnumToString.convertToString(Status.Booked);
    print(driver);
    //getDriverDetails();
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
       print('*******$state********');
       switchState(EnumToString.convertToString(Status.Dispatched));
       switchToDispatchedState();
     }
    }
    else if(state== EnumToString.convertToString(Status.OnGoing)){
      switchToOnGoingState();
    }
    else if(state == EnumToString.convertToString(Status.Cancelled)){
      unassignDriver();
      switchToCancelledState();
    }
    setBusy(false);
  }

  switchGroupValue(int val){
    groupValue = val;
    setBusy(false);
  }


  Future<DriverModel?> checkDriver() async {
    setBusy(true);
    print("Method Called GetDriverDetails 1 ");
    await getDriverDetails();
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

  void switchToOnGoingState() {
    repo.switchToOnGoingState(requestId);
  }

  switchButtonState(int state){
    buttonState=state;
    setBusy(false);
  }

  getDriverDetails()async {
    print("Method Called GetDriverDetails 2");
     driverModel = await repo.getDriverDetails();
     print(driverModel!.driverName);
  }
}