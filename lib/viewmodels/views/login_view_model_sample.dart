import 'package:flutter/widgets.dart';
import 'package:bluetaxiapp/data/repository/auth_repository_sample.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class LoginViewModelSample extends BaseModel {
  AuthRepositorySample _authRepository;

  LoginViewModelSample({
    required AuthRepositorySample authRepository,
  }) : _authRepository = authRepository;

  Future<bool> login(String userIdText) async {
    setBusy(true);
    var userId = int.tryParse(userIdText);
    var success = await _authRepository.login(userId!);
    setBusy(false);
    return success;
  }
}
