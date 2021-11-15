import 'package:bluetaxiapp/data/model/ride_model.dart';
import 'package:bluetaxiapp/data/model/user_model.dart' as userModel;
import 'package:bluetaxiapp/data/remote/firebase_directory/database_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Api {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late var firestoreDb = FirebaseFirestore.instance.collection("users").snapshots();
  late var  firestoreRequests = firestore.collection("request");



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


  Future getUsersStream() async {
    return await FirebaseFirestore.instance.collection("users").get();
  }


  Future<userModel.UserModel> signInWithEmailPassword(String phoneNo, String password) async{
    bool exist = false;
    userModel.UserModel user = userModel.UserModel(id: '');
    exist=await getUsersStream().
    then((val){
      if(val.docs.length > 0){
        int index=val.docs.length;
        print("***************************Index is: "+index.toString());
        for(var i=0; i<index;i++){
          if(phoneNo == val.docs[i].data()['phoneNo']){
            if(password == val.docs[i].data()['password']){
              print("Password Matched");
              //Return Bool True(Credentials are Okay) To View class so it can proceed
              user.phoneno = val.docs[i].data()['phoneNo'];
              user.id = val.docs[i].id;
              user.name=val.docs[i].data()['name'];
              user.address = val.docs[i].data()['address'];
              user.email = val.docs[i].data()['email'];
              user.type = val.docs[i].data()['type'];
              exist = true;
            }
            else{
              print("Password didnt Matched");
              print(password + val.docs[i].data()['password']);
              exist = false;
            }
          }
        }
        return exist;
      }
      else{
        //No Document Exists
        print("Not Found");
        return false;
      }
    })
        .catchError((error) {return false;});
    print("EXist value After GetData()" );
    return user;
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

 // Book a ride
  Future generateRequest(
      {required String userToken,
        String toAdress="ABC",
        String fromAdress="XYZ",
        String paymentMethod="Unknown",
        required String carType,
        required String expectedBill,
      }) async {
    late RideModel ride;
    if( await checkRequestStatus(userToken)){
      bool check=false;
      check=await firestoreRequests.add({
        "userId":userToken,
        "riderId":'',
        "toAdress":toAdress,
        "fromAdress":fromAdress,
        "PaymentMethod":paymentMethod,
        "carType":carType,
        "expectedBill":'',
        "rideStatus":0,
      }).then((value) {
        print(value.id);
        ride = RideModel(
            id: value.id,
            paymentMethod: paymentMethod,
            carType: carType,
            expectedBill: expectedBill,
            fromAdress: fromAdress,
            toAdress: toAdress,
            rideStatus: 0,
            riderId: '',
            userId: userToken
        );
        return true;
      }).catchError((e){
        print(e);
        return false;
      });
    }
    return ride;
  }

  Future<bool> checkRequestStatus(String userToken) async{
    var stream = await firestoreRequests
        .where('userId',isEqualTo: userToken)
        .get();
    var finalstream = await stream.docs.where((element) => element["rideStatus"] != 2);
    if(finalstream.length==0)
      return  true;
    return false;
  }

}
