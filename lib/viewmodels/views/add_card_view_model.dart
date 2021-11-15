import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';


class AddCardViewModel extends BaseModel{

  final AuthRepository _repo ;

  //variabels who are going to communicate with UI
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController expMonthController = TextEditingController();
  final TextEditingController expYearController = TextEditingController();

  AddCardViewModel({
    required AuthRepository repo
  }): _repo = repo,super(false);

  addCard() async{
    setBusy(true);
    if(
      cardHolderController.text.length>4&&
      cardNumberController.text.length>4&&
      expYearController.text.length>0&&
      expYearController.text.length<=2&&
      expYearController.text.length==4
    )
    {
      bool ans = await _repo.addCard(
          cardNumber: cardNumberController.text,
          cardHolder: cardHolderController.text,
          expMonth: int.parse(expMonthController.text),
          expYear: int.parse(expYearController.text)
      );
      ans?print("ok"):print("not ok");
    }
    setBusy(false);
  }


}