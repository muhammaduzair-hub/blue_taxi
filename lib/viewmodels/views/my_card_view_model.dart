import 'package:bluetaxiapp/data/model/card_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class MyCardViewModel extends BaseModel{

  final AuthRepository _repo ;
  late List<CardModel> myCards = [
    // CardModel( leadingImage: AssetImage("asset/icons/ic_mastercard.png"), cardNumber: "**** 8965",),
    // CardModel( leadingImage: AssetImage("asset/icons/ic_visa.png"), cardNumber: "**** 8965",),
    // CardModel( leadingImage: AssetImage("asset/icons/ic_mastercard.png"), cardNumber: "**** 8965",),
    // CardModel( leadingImage: AssetImage("asset/icons/ic_visa.png"), cardNumber: "**** 8965",),
  ];

  MyCardViewModel({
    required AuthRepository repo
  }): _repo = repo,super(false){
    getcards();
  }

  getcards()async{
    setBusy(true);
    myCards = await _repo.api.getCards();
    setBusy(false);
  }
}