import 'package:bluetaxiapp/data/local/local_api.dart';
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/remote/api.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/data/repository/auth_repository_sample.dart';
import 'package:bluetaxiapp/viewmodels/views/signin_signup_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'data/model/user_sample.dart';
import 'data/remote/api_sample.dart';

List<SingleChildWidget> providers = [
  ...independentServicesSample,
  ...independentLocalService,
  ...dependentServicesSample,
  ...uiConsumableProvidersSample,

  //the actual providers
  ...independentRemoteService,
  ...independentLocalService,
  ...dependentService,
  ...uiConsumableProviders,
  ...credientailProvider,
];

List<SingleChildWidget> independentServicesSample = [
  Provider.value(value: ApiSample())
];
List<SingleChildWidget> independentLocalServicesSample = [
  Provider.value(value: ApiSample())
];
List<SingleChildWidget> dependentServicesSample = [
  ProxyProvider2<ApiSample, LocalApi, AuthRepositorySample>(
    update: (context, value, value2, previous) =>
        AuthRepositorySample(api: value, localApi: value2),
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

List<SingleChildWidget> credientailProvider = [
  ChangeNotifierProvider(
      create: (context) => SignInSignUpViewModel(repo: Provider.of(context)))
];
List<SingleChildWidget> independentRemoteService = [
  Provider.value(value: Api())
];
List<SingleChildWidget> independentLocalService = [
  Provider.value(value: LocalApi())
];
List<SingleChildWidget> dependentService = [
  ProxyProvider2<Api, LocalApi, AuthRepository>(
    update: (context, api, localApi, repo) =>
        AuthRepository(api: api, localApi: localApi),
  ),
];
