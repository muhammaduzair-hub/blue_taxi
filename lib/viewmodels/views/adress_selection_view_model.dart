import 'package:bluetaxiapp/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:bluetaxiapp/data/repository/auth_repository_sample.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class AdressSelectionViewModel extends BaseModel {
  AuthRepositorySample _authRepository;

  //varibles who are going to communicate with UI


  TextEditingController toController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  String state;
  String titleText;

  //for disable button of ride option state bottom sheet
  int index=0;

  AdressSelectionViewModel({@required AuthRepositorySample authRepository,})
  {
    _authRepository = authRepository;
    state = LabelSelectAdress;
  }

  switchState(String newstate){
    setBusy(true);
    state =newstate;
    setBusy(false);
  }

  switchRideOptionButtonIndex(int newIndex){
    setBusy(true);
    index= newIndex;
    setBusy(false);
  }
}
