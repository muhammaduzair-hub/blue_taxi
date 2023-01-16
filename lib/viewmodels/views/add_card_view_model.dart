import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/card_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';


class AddCardViewModel extends BaseModel{

  final AuthRepository _repo ;

  //variabels who are going to communicate with UI
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  late bool cardValidator = true;
  late bool holderValidator = true;
  DateTime? selectedDate;

  AddCardViewModel({
    required AuthRepository repo
  }): _repo = repo,super(false){
    selectedDate= DateTime.now();
  }


  getcards()async{

    return  await _repo.api.getCards();
  }

  addCard(BuildContext context) async{
    cardValidator =  validateCardNumber(cardNumberController.text);
    holderValidator = validateName(cardHolderController.text);
    setBusy(false);
    if(cardValidator && holderValidator&& selectedDate!=null)
    {
      setBusy(true);
      bool ans = await _repo.addCard(
          cardNumber: cardNumberController.text,
          cardHolder: cardHolderController.text,
          expMonth:selectedDate!.month,
          expYear: selectedDate!.year
      );
      if(ans){
        List<CardModel> cards=await getcards();
        Navigator.pop(context, cards);
        showToast(LabelCardIsAdded);
      }
      else{
        showToast(LabelTryAgain);
        cardNumberController.text ='';
        cardHolderController.text = '';
      }
    }
    else{
      // showToast(
      //   !cardValidator ? LabelLenghtMustBeSixteen : !holderValidator ? LabelInvalidName : LabelTryAgain
      // );
    }
    setBusy(false);
  }

  bool validateCardNumber(String value) {
    bool ans;
    String pattern = r"^(?:(\d{16}))$";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      ans= false;
    }
    else if (!regExp.hasMatch(value)) {
      ans= false;
    }
    else {
      ans = true;

    }
    return ans;
  }

  bool validateName(String value){
    bool ans;
    String pattern = r'^[a-zA-Z][[a-zA-Z\s]+[a-zA-Z]]*$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      ans= false;
    }
    else if (!regExp.hasMatch(value)) {
      ans= false;
    }
    else {
      ans = true;
    }

    setBusy(false);
    return ans;
  }


  monthPicker(BuildContext context){
    // showMonthPicker(
    //   context: context,
    //   firstDate: DateTime(DateTime.now().year, DateTime.now().month),
    //   lastDate: DateTime(DateTime.now().year + 10),
    //   initialDate: selectedDate ?? DateTime.now(),
    // ).then((date) {
    //   if (date != null) {
    //     selectedDate = date;
    //     setBusy(false);
    //   }
    // });
  }


}