import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:bluetaxiapp/data/repository/auth_repository_sample.dart';

import 'data/model/user_sample.dart';
import 'data/remote/api_sample.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [Provider.value(value: ApiSample())];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<ApiSample, AuthRepositorySample>(
    update: (context, api, repository) =>
        AuthRepositorySample(api: api),
  )
];

List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<UserSample>(
    create: (context) =>
        Provider.of<AuthRepositorySample>(context, listen: false).user,
    initialData: UserSample.initial(),
  )
];
