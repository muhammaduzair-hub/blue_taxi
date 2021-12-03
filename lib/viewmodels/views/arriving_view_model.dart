import 'dart:async';
import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:enum_to_string/enum_to_string.dart';



class ArrivingSelectionViewModel extends BaseModel {
  final AuthRepository repo;
  late Future<dynamic> driver;
  final String requestId;
  late int buttonState=1;
  late int groupValue= -1;
  dynamic driverModel;
  bool cancelModel=false;



  ArrivingSelectionViewModel(this.requestId, {required this.repo}) : super(false) {
    driver = getRequest(requestId);
    state= EnumToString.convertToString(Status.Booked);
    print("Driver Id $driver*****************");
    //To Pop the Cancellation Reason View
    //getDriverDetails();
  }

  @override
  dispose(){
  }
  int i=0;
  switchState(String newstate) async {
    setBusy(true);
    state = newstate;
    print('*******$state $i***START*****');
    if(state == EnumToString.convertToString(Status.Active)) {
      print("$state == ${EnumToString.convertToString(Status.Active)}");
     // startTimer
    await Future.delayed(Duration(seconds: 5));
     if(state !=  EnumToString.convertToString(Status.Cancelled)){
       setBusy(false);
       print('****BEFORE***$state***$i*****');
       cancelModel=false;
       switchState(EnumToString.convertToString(Status.Dispatched));
       print('*****AFTER**$state****$i****');
       setBusy(false);
       switchToDispatchedState();
     }
    }
    else if(state== EnumToString.convertToString(Status.OnGoing)){
      switchToOnGoingState();
    }
    else if(state == EnumToString.convertToString(Status.Cancelled)){
      print('Cancelled*************');
      unassignDriver();
      switchToCancelledState();
    }
    print('*******$state***$i***END**');
    setBusy(false);
  }

  switchGroupValue(int val){
    groupValue = val;
    setBusy(false);
  }


   checkDriver() async {
    setBusy(true);
    if(driver!=null)
      {
        await getDriverDetails();
        switchState(EnumToString.convertToString(Status.Active));
      }
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

   getRequest(String uid) async {
    await repo.getRequestData(uid);
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

    driverModel  =await repo.getDriverDetails();
    print("*****************Method Called GetDriverDetails 2******************************$driverModel");
    if(driverModel == null){
      driverState=false;
    }
    else{
    }
    return driverModel;
  }
}