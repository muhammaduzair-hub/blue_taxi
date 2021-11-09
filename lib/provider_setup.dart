import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/remote/api.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:bluetaxiapp/data/repository/auth_repository_sample.dart';

import 'data/model/user_sample.dart';
import 'data/remote/api_sample.dart';

List<SingleChildWidget> providers = [
  ...independentServicesSample,
  ...dependentServicesSample,
  ...uiConsumableProvidersSample,
  ...independentService,
  ...dependentService,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServicesSample = [Provider.value(value: ApiSample())];

List<SingleChildWidget> dependentServicesSample = [
  ProxyProvider<ApiSample, AuthRepositorySample>(
    update: (context, api, repository) =>
        AuthRepositorySample(api: api),
  )
];

List<SingleChildWidget> uiConsumableProvidersSample = [
  StreamProvider<UserSample>(
    create: (context) =>
        Provider.of<AuthRepositorySample>(context, listen: false).user,
    initialData: UserSample.initial(),
  )
];


List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<UserModel>(
    create: (context) =>
    Provider.of<AuthRepository>(context, listen: false).user,
    initialData: UserModel.initial(),
  )
];


List<SingleChildWidget> independentService = [Provider.value(value: Api())];
List<SingleChildWidget> dependentService = [
  ProxyProvider<Api, AuthRepository>(
    update: (context, api, repo) => AuthRepository(api: api),
  ),
];