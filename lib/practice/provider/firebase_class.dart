import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseClass extends StatelessWidget {
  FirebaseClass({Key? key}) : super(key: key);

  var firestoreDb = FirebaseFirestore.instance.collection("users").snapshots();

  TextEditingController fnameInputController = TextEditingController(text: "");
  TextEditingController lnameInputController = TextEditingController(text: "");
  TextEditingController emailInputController = TextEditingController(text: "");
  TextEditingController passwordInputController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text("Firebase"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'First Name',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (fnameInputController.text.isNotEmpty &&
                            lnameInputController.text.isNotEmpty &&
                            emailInputController.text.isNotEmpty &&
                            passwordInputController.text.isNotEmpty) {
                          FirebaseFirestore.instance.collection("users").add({
                            "firstname": fnameInputController.text,
                            "lastname": lnameInputController.text,
                            "email": emailInputController.text,
                            "password": passwordInputController.text,
                            "timestamp": new DateTime.now()
                          }).then((response) {
                            print("***************************************************"+response.id);
                            Navigator.pop(context);
                            fnameInputController.clear();
                            lnameInputController.clear();
                            emailInputController.clear();
                            passwordInputController.clear();
                          }).catchError((error) => print("***************************************************************" +error));
                        }
                      },
                      child: Text("Sign up")),
                  ElevatedButton(onPressed: () {
                    print(FirebaseFirestore.instance.collection("users").snapshots());
                  }, child: Text("Get")),
                ],
              ),
            )));
  }
}
