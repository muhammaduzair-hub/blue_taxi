import 'package:bluetaxiapp/data/model/user_model.dart' as userModel;
import 'package:bluetaxiapp/data/remote/firebase_directory/database_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Api {
  bool exists=false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var firestoreDb = FirebaseFirestore.instance.collection("User").snapshots();


  // create user obj based on firebase user
  userModel.UserModel? _userFromFirebaseUser(User user) {
    return user != null ? userModel.UserModel( id: user.uid) : null;
  }



  Future signUpWithEmailPassword(String nameController, String emailController,String phoneNoController, String passwordController) async {
    await FirebaseFirestore.instance.collection("users").add({
      "name" : nameController,
      "email" : emailController,
      "phoneNo" : phoneNoController,
      "password" : passwordController,
      "address" : "Address NotFound",
      "type" : "Type NotFound",

      "timestamp" : new DateTime.now()
    }).then((response) {
      print(response.id);
      return response.id;
    }
    ).catchError((error) => print(error),
    );
  }


  Future getData() async {
    return await FirebaseFirestore.instance.collection("users").get();
  }
  Future<bool> signInWithEmailPassword(String phoneNo, String password) async{
    exists =await getData().
    then((val){
      if(val.docs.length > 0){
        int index=val.docs.length;
        print("***************************Index is: "+index.toString());
        for(var i=0; i<index;i++){
          if(phoneNo == val.docs[i].data()['phoneNo']){
            if(password == val.docs[i].data()['password']){
              i=index;
              print("Password Matched");
              //Return Bool True(Credentials are Okay) To View class so it can proceed
              exists=true;
            }
            else{
              print("Password didnt Matched");
              print(password + val.docs[i].data()['password']);
              //Return Bool False
              exists=false;
            }
          }
        }
        return exists;
      }
      else{
        //No Document Exists
        exists=false;
        print("Not Found");
        return exists;
      }
    }).catchError((error) {exists= false;});


    print("EXist value After GetData()" +exists.toString());
    return exists;
  }

  // register with email and password
  Future registerWithEmailAndPassword(String name,String email, String phoneNo, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).addUserData(name,email,phoneNo,password, "No Address Found", "Undefined RN");

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}
