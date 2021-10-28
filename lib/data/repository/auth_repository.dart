import 'dart:async';

import 'package:bluetaxiapp/data/model/user.dart';
import 'package:bluetaxiapp/data/remote/api.dart';

class AuthRepository {
  final Api _api;

  AuthRepository({Api api}) : _api = api;

  StreamController<User> _userController = StreamController<User>();

  Stream<User> get user => _userController.stream;

  Future<bool> login(int userId) async {
    var fetchedUser = await _api.getUserProfile(userId);

    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    }

    return hasUser;
  }
}
