import 'package:flutter/widgets.dart';
import 'package:bluetaxiapp/data/repository/auth_repository_sample.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class AdressSelectionViewModel extends BaseModel {
  AuthRepositorySample _authRepository;

  //varibles who are going to communicate with UI
  TextEditingController toController = TextEditingController();
  TextEditingController fromController = TextEditingController();

  AdressSelectionViewModel({
    @required AuthRepositorySample authRepository,
  }) : _authRepository = authRepository;


}
