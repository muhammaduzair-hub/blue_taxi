import 'package:bluetaxiapp/ui/views/dev_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluetaxiapp/provider_setup.dart';
import 'package:firebase_core/firebase_core.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                return Text("SomethingWentWrong");
              }
              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                return MultiProvider(
                  providers: providers,
                  child: MaterialApp(
                    title: 'Flutter Demo',
                    theme:  ThemeData(
                            primarySwatch: Colors.blue,
                          ),
                    home: DevScreenView(),
                  ),
                );
              }
              // Otherwise, show something whilst waiting for initialization to complete
              return CircularProgressIndicator();
            },
    );










    // return MultiProvider(
    //   providers: providers,
    //   child: MaterialApp(
    //     title: 'Flutter Demo',
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //     ),
    //     home: FutureBuilder(
    //       // Initialize FlutterFire
    //       future: Firebase.initializeApp(),
    //       builder: (context, snapshot) {
    //         // Check for errors
    //         if (snapshot.hasError) {
    //           return Text("SomethingWentWrong");
    //         }
    //
    //         // Once complete, show your application
    //         if (snapshot.connectionState == ConnectionState.done) {
    //           return DevScreenView();
    //         }
    //
    //         // Otherwise, show something whilst waiting for initialization to complete
    //         return CircularProgressIndicator();
    //       },
    //     ),
    //
    //     //DevScreenView(),
    //     //home: SignInSignUpView(),
    //   ),
    // );
  }
}