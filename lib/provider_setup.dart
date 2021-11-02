import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';

import 'data/model/user_sample.dart';
import 'data/remote/api.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [Provider.value(value: Api())];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Api, AuthRepository>(
    update: (context, api, repository) =>
        AuthRepository(api: api),
  )
];

List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<UserSample>(
    create: (context) =>
        Provider.of<AuthRepository>(context, listen: false).user,
    initialData: UserSample.initial(),
  )
];
