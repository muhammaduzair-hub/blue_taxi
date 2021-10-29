import 'dart:async';

import 'package:bluetaxiapp/data/model/user_sample.dart';
import 'package:bluetaxiapp/data/remote/api_sample.dart';

class AuthRepositorySample {
  final ApiSample _api;

  AuthRepositorySample({ApiSample api}) : _api = api;

  StreamController<UserSample> _userController = StreamController<UserSample>();

  Stream<UserSample> get user => _userController.stream;

  Future<bool> login(int userId) async {
    var fetchedUser = await _api.getUserProfile(userId);

    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    }

    return hasUser;
  }
}
