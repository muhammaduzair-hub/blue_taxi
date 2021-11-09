

import 'dart:async';

import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/remote/api.dart';

class AuthRepository{
  final Api _api;

  AuthRepository({required Api api}):_api= api;
  
  StreamController<UserModel> _userController = StreamController<UserModel>();
  Stream<UserModel> get user => _userController.stream;


}