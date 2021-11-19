import 'dart:io';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //The controller of my form
  final myController = TextEditingController();

  //The response of the API request
  String _response = 'No answer';

  //Call of the hello function
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'hello',
      options: HttpsCallableOptions(timeout: Duration(seconds: 5)));

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await fetchPost();
          return showDialog(
              builder: (context) => AlertDialog(
                  title: Text('Alert'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('The answer'),
                        Text(_response),
                      ],
                    ),
                  )), context: context);
        },
        child: Icon(Icons.add_alert),
      ),
    );
  }

  fetchPost() async {
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'message': myController.text,
        },
      );
      print(result.data['response']);
      setState(() {
        _response = result.data['response'];
      });
    } on PlatformException catch (e) {
      print('caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
    } catch (e) {
      print('caught generic exception');
      print(e);
    }
  }
}

//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   _NotificationScreenState createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   String messageTitle = "Empty";
//   String notificationAlert = "alert";
//
//   void initState(){
//     super.initState();
//
//     FirebaseMessaging.instance.getInitialMessage();
//
//     FirebaseMessaging.onMessage.listen((message){
//       if(message.notification != null){
//         print(message.notification!.body);
//         print(message.notification!.title);
//       }
//     });
//   }
//   // FirebaseFunctions functions = FirebaseFunctions.instance;
//   // functions = require('firebase-functions');
//   // exports.listFruit = functions.https.onCall((data, context) => {
//   // return ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
//   // });
//
//
//   Future<void> getFruit() async {
//     HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('listFruit');
//     final results = await callable();
//     List fruit = results.data;  // ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("title"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               notificationAlert,
//             ),
//             Text(
//               messageTitle,
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//   // Future<String?> _fcm = FirebaseMessaging.instance.getToken();
//   // Future initialize() async{
//   //   if(Platform.isIOS){
//   //     //_fcm.requestNotificationfunctionpermissions(IosNotificationSettings());
//   //   }
//   // }
//
