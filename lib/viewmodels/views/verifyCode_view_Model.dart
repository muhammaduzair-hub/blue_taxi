import 'dart:async';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';



//final fAuth.FirebaseAuth auth = fAuth.FirebaseAuth.instance;

class VerifyCodeViewModel extends BaseModel{
  late final phoneno;
  final AuthRepository _repo ;
  int start = 30;
  late Timer _timer;

  VerifyCodeViewModel({
  required AuthRepository repo
}): _repo = repo;



  // Future<String?> inputData() async {
  //
  //   final fAuth.User? user = auth.currentUser;
  //   final uid = user!.uid;
  //    phoneno=user.phoneNumber;
  //   print(phoneno);
  //   return phoneno;
  // }

  void startTimer() async{
    while(true){
      setBusy(true);
      await Future.delayed(Duration(milliseconds: 1000));
      if(start>0){
        start--;
      }
      print(start);
      setBusy(false);
    }
  }

   changeData(String resend_code) {
    setBusy(true);
    startTimer();
    setBusy(false);

  }

  dispose() {
    _timer.cancel();
    super.dispose();
  }

}