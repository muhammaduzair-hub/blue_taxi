import 'package:bluetaxiapp/data/model/user_model.dart' as userModel;
import 'package:bluetaxiapp/data/remote/firebase_directory/database_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthService {
//
//   final FirebaseAuth _authh = FirebaseAuth.instance;
//   var firestoreDb = FirebaseFirestore.instance.collection("User").snapshots();
//
//
//   // create user obj based on firebase user
//   userModel.UserModel? _userFromFirebaseUser(User user) {
//     return user != null ? userModel.UserModel( id: user.uid) : null;
//   }
//
//
//
//   // register with email and password
//   Future registerWithEmailAndPassword(String name,String email, String phoneNo, String password) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       User? user = result.user;
//       // create a new document for the user with the uid
//       await DatabaseService(uid: user!.uid).addUserData(name,email,phoneNo,password, "No Address Found", "Undefined RN");
//
//       return _userFromFirebaseUser(user);
//     } catch (error) {
//       print(error.toString());
//       return null;
//     }
//   }
//
//   // sign out
//   Future signOut() async {
//     try {
//       return await _auth.signOut();
//     } catch (error) {
//       print(error.toString());
//       return null;
//     }
//   }
//
// }
