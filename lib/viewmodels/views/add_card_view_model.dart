import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';


class AddCardViewModel extends BaseModel{

  final AuthRepository _repo ;


  //variabels who are going to communicate with UI
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  DateTime? selectedDate;

  AddCardViewModel({
    required AuthRepository repo
  }): _repo = repo,super(false){
    selectedDate= DateTime.now();
  }


  getcards()async{

    return  await _repo.api.getCards();
  }

  addCard() async{
    setBusy(true);
    if(
      cardHolderController.text.length>4&&
      cardNumberController.text.length==16 &&
      selectedDate!=null
    )
    {
      bool ans = await _repo.addCard(
          cardNumber: cardNumberController.text,
          cardHolder: cardHolderController.text,
          expMonth:selectedDate!.month,
          expYear: selectedDate!.year
      );
      // ans?print("ok"):print("not ok");
    }
    setBusy(false);
  }

  monthPicker(BuildContext context){
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year, DateTime.now().month),
      lastDate: DateTime(DateTime.now().year + 10),
      initialDate: selectedDate ?? DateTime.now(),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        setBusy(false);
      }
    });
  }


}