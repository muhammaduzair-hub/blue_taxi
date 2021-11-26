
import 'dart:async';

import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';



//final fAuth.FirebaseAuth auth = fAuth.FirebaseAuth.instance;

class VerifyCodeViewModel extends BaseModel{
  late final phoneno;
  final AuthRepository _repo ;
  final BuildContext _context;
  int start = 30;
  late Timer _timer;

  final boxControllers = [TextEditingController(text: ''),TextEditingController(text: ''),TextEditingController(text: ''),TextEditingController(text: ''),];
  final boxFocusNodes = [FocusNode(),FocusNode(),FocusNode(),FocusNode()];


  VerifyCodeViewModel({
  required AuthRepository repo,
    required BuildContext context
}): _repo = repo,_context= context,super(false);





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

  @override
  void dispose() {
    
    _timer.cancel();
    super.dispose();
  }

  void switchToBackTextField(index, BuildContext context) {
    setBusy(true);
    boxControllers[index-1].text = "";
    FocusScope.of(context).requestFocus(boxFocusNodes[index - 1]);
    setBusy(false);
  }

  void switchToNextField(index, String val, BuildContext context){
    setBusy(true);
    // boxControllers[index].text = val;
    // boxControllers[index+1].text = "";

    setBusy(false);
  }

  void assignValue(TextEditingController controller, String val){
    setBusy(true);
    controller.text = val;
    setBusy(false);
  }


}