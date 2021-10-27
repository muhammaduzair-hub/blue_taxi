
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'firebase_class.dart';
import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '0',
              style: Theme.of(context).textTheme.headline4,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapClass()),
                );
              },
              icon: Icon(
                Icons.account_box,
                color: Colors.black87,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) {
                        return FutureBuilder(

                          future: Firebase.initializeApp(),
                          builder: (context, snapshot) {

                            if (snapshot.connectionState == ConnectionState.done) {
                              return FirebaseClass();
                            }

                            // Otherwise, show something whilst waiting for initialization to complete
                            return CircularProgressIndicator();
                          },
                        );
                      }
                  ),
                );
              },
              icon: Icon(
                Icons.table_rows,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, //_incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
