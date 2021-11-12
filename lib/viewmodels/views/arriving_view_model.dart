import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class ArrivingSelectionViewModel extends BaseModel {
  final AuthRepository repo;
  late String state;


  ArrivingSelectionViewModel({required this.repo}) {
    state=LabelSearching;
    Future.delayed(Duration(seconds: 1), () {
      switchState(LabelArriving);
    });
  }

  switchState(String newstate){
    setBusy(true);
    state =newstate;
    if(newstate==LabelArriving){
      Future.delayed(Duration(seconds: 5), () {
        switchState(LabelArrived);
      });
    }
    setBusy(false);
  }


}