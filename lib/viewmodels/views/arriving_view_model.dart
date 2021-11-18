import 'dart:async';

import 'package:bluetaxiapp/constants/strings.dart';
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
  late String OneBState='true';
  late String TwoBState='false';
  late String ThreeBState='false';
  late String FourBState='false';



  ArrivingSelectionViewModel({required this.requestId, required this.repo}) : super(false) {
    state = EnumToString.convertToString(Status.Booked);

    print(state);
    driver = getRequest(requestId);
    print(driver);
  }

  switchState(String newstate) {
    setBusy(true);
    state = newstate;
    if(state == EnumToString.convertToString(Status.Active)) {
      Timer(Duration(seconds: 8), () {
        switchState(EnumToString.convertToString(Status.Dispatched));
      });
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
    repo.unassignDriver(requestId);
  }



  // void switchButtonState(String BState) {
  //   setBusy(true);
  //   BState= 'true';
  //   if(OneBState == 'true'){
  //     TwoBState ='false';
  //     ThreeBState ='false';
  //     FourBState = 'false';
  //   }
  //   else if(TwoBState == 'true'){
  //     OneBState ='false';
  //     ThreeBState ='false';
  //     FourBState = 'false';
  //   }
  //   else if(ThreeBState == 'true'){
  //     OneBState ='false';
  //     TwoBState ='false';
  //     FourBState = 'false';
  //   }
  //   else if(FourBState == 'true'){
  //     OneBState ='false';
  //     ThreeBState ='false';
  //     TwoBState = 'false';
  //   }
  //   setBusy(false);
  // }

}