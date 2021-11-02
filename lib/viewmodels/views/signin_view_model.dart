import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:flutter/widgets.dart';
//import 'package:bluetaxiapp/data/repository/auth_repository_sample.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class SigninViewModel extends BaseModel {
  AuthRepository _authRepository;

  SigninViewModel({
    @required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Future<bool> login(String userIdText) async {
    setBusy(true);
    var userId = int.tryParse(userIdText);
    var success = await _authRepository.login(userId);
    setBusy(false);
    return success;
  }
}
