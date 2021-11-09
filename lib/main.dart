import 'package:bluetaxiapp/ui/views/dev_screen.dart';
import 'package:bluetaxiapp/ui/views/home_view_sample.dart';
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluetaxiapp/provider_setup.dart';
import 'package:bluetaxiapp/ui/app_router.dart';

import 'constants/app_contstants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DevScreenView(),
        //home: SignInSignUpView(),
        // onGenerateRoute: AppRouter.generateRoute,
        // initialRoute: RoutePaths.DemoPage,

      ),
    );
  }
}