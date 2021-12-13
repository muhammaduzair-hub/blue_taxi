import 'package:bluetaxiapp/ui/views/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bluetaxiapp/provider_setup.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

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
                  child: RootRestorationScope(
                    restorationId: 'root',
                    child: MaterialApp(
                      title: 'Flutter Demo',
                      theme:  ThemeData(
                              primarySwatch: Colors.blue,
                            ),
                      home:MySplashScreenView()
                    ),
                  ),
                );
              }
              // Otherwise, show something whilst waiting for initialization to complete
              return Center(child: CircularProgressIndicator());
            },
    );
  }
}