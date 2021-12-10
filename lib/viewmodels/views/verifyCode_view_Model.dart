import 'dart:async';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeViewModel extends BaseModel{
  late final phoneno;
  final AuthRepository _repo ;
  final BuildContext _context;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  VerifyCodeViewModel({
  required AuthRepository repo,
    required BuildContext context
}): _repo = repo,_context= context,super(false){
    print("Inside controller 1");
    errorController = StreamController<ErrorAnimationType>();
  }
}