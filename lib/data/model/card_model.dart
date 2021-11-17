import 'package:flutter/cupertino.dart';

class CardModel{
  final AssetImage leadingImage;
  final String cardNumber;


  CardModel({required this.leadingImage, required this.cardNumber});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      leadingImage:  AssetImage("asset/icons/shape.png"),
      cardNumber: "****"+json['cardNumber']
    );
  }
}