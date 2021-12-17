import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/ui/views/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bluetaxiapp/provider_setup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui' as ui;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        MediaQuery(
          data: new MediaQueryData.fromWindow(ui.window),
          child: Directionality(
          textDirection: TextDirection.rtl, child: MyApp()
          ),
        ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

 var mediaQuery = MediaQuery.of(context);
     width = mediaQuery.size.width;
     print(width);
     height = mediaQuery.size.height;
 print(height);
     heightWithAppBar = mediaQuery.size.height - (mediaQuery.padding.top + kToolbarHeight);
 print(heightWithAppBar);
      smallPadding= EdgeInsets.only(left: height*1/60);
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