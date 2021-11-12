import 'dart:async';

import 'package:bluetaxiapp/data/local/local_api.dart';
import 'package:bluetaxiapp/data/model/user_sample.dart';
import 'package:bluetaxiapp/data/remote/api_sample.dart';

class AuthRepositorySample {
  final ApiSample _api;
  final LocalApi _localApi;

  AuthRepositorySample({required ApiSample api,required LocalApi localApi}) : _api = api, _localApi=localApi;

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
