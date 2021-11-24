import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:bluetaxiapp/data/repository/auth_repository_sample.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class DriverDetailViewModel extends BaseModel {
  AuthRepository _authRepository;

  DriverDetailViewModel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository,super(false);

}
