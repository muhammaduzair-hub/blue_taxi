
import 'package:bluetaxiapp/provider_practice/provider/counter_state.dart';
import 'package:bluetaxiapp/provider_practice/provider/user_dto_state.dart';
import 'package:bluetaxiapp/provider_practice/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterState()),
        ChangeNotifierProvider(create: (context) => UserDTOState()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignUp(),
      ),
    );
  }
}