import 'package:flutter/widgets.dart';
import 'package:bluetaxiapp/data/repository/auth_repository_sample.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class DriverDetailViewModel extends BaseModel {
  AuthRepositorySample _authRepository;

  DriverDetailViewModel({
    @required AuthRepositorySample authRepository,
  }) : _authRepository = authRepository;


}
