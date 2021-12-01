import 'package:bluetaxiapp/data/model/adress_model.dart';
import 'package:bluetaxiapp/data/model/card_model.dart';
import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/data/model/requestData_model.dart';
import 'package:bluetaxiapp/data/model/request_model.dart';
import 'package:bluetaxiapp/data/model/user_model.dart' as userModel;
import 'package:bluetaxiapp/data/remote/firebase_directory/database_config.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/viewmodels/views/arriving_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Api {

  dynamic driverID=null;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
 // late var firestoreDb = FirebaseFirestore.instance.collection("users").snapshots();
  late var  firestoreRequests = firestore.collection("request");
  late var firestoreAdresses = firestore.collection("addresses");


  late var fireStoreCards = firestore.collection("cards");
  late var fireStoreUsers = firestore.collection("users");


  final _requestCollectionReference =
  FirebaseFirestore.instance.collection("request");

  final _driverCollectionReference =
  FirebaseFirestore.instance.collection("driver");



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
        for(var i=0; i<index;i++){
          if(phoneNo == val.docs[i].data()['phoneNo']){
            if(password == val.docs[i].data()['password']){
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
              exist = false;
            }
          }
        }
        return exist;
      }
      else{
        //No Document Exists
        return false;
      }
    })
        .catchError((error) {return false;});
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
        required AdressModel toAdress,
        required AdressModel fromAdress,
        required CardModel card,
        required String carType,
        required String expectedBill,
      }) async {
    late String ride;
    if( await checkRequestStatus(userToken)){
      bool check=false;
      check=await firestoreRequests.add({
        "userId":userToken,
        "riderId":'',
        "Addresses": {
          'from':{
            "place_name": fromAdress.adressTitle,
            "lat": fromAdress.lat,
            "lng": fromAdress.long
          },
          'to':{
            "place_name": toAdress.adressTitle,
            "lat": toAdress.lat,
            "lng": toAdress.long
          },
        },
        "payment":{
          "type":card.cardNumber=="Cash"?"Cash":"Card",
          "card_no":card.cardNumber,
        },
        "carType":carType,
        "expectedBill":'',
        "rideStatus":EnumToString.convertToString(Status.Booked),
        "createDate":DateTime.now(),

      }).then((value) {
        print(value.id);
        ride = value.id;
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
    var finalstream = await stream.docs.where(
            (element) =>
              element["rideStatus"] != 'Completed'
                  &&
                  element["rideStatus"] !='Cancelled'
    );
    if(finalstream.length==0)
      return  true;
    return false;
  }

  Future<DriverModel?> getRequestData(String rid) async {
    DriverModel? driverDataModel=null;
    try{
      driverID = await getActiveDriver();

      var requestData = await _requestCollectionReference.doc(rid).get()
          .whenComplete(() async {
        await updateRequestData(rid, driverID);
      });

    } catch (e) {
      return driverDataModel;
    }
    return driverDataModel;
  }

  getActiveDriver() async {
    try {
      //Getting any driver in INACTIVE STATE (0),
      // Changing Driver Status to 1 and assigning him to Request
      var dData = await _driverCollectionReference.where('driverStatus' , isEqualTo: "Unassigned")
          .limit(1)
          .get()
          .then((value) =>
          value.docs.forEach((doc)=> {
            print("*********** AT API DRIVER NAME IS : ${doc['driverName']}"),
            doc.reference.update({'driverStatus' : 'Assigned'}),//CHANGE***********
            driverID= doc.id,
          })
      );
      return driverID;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateRequestData(String rid, String driverId) async {
    return await _requestCollectionReference.doc(rid).update({
      'riderId': driverId,
      'rideStatus': 'Active',//CHANGE***********
    });
  }

  Future<void> unassignDriver() async {
    if(driverID !=null)
    return await _driverCollectionReference.doc(driverID).update({
    'driverStatus' : 'Unassigned'
    });
  }

  Future addCard({required String cardNumber, required String cardHolder, required int expMonth, required int expYear}) async{
    if(await checkCardsAlreadyFound(cardNumber)){
      bool check = false;
      check = await fireStoreCards.add({
        "userId":signedINUser.id,
        "cardNumber":cardNumber,
        "cardHolderName":cardHolder,
        "expMonth":expMonth,
        "expYear":expYear
      })
          .then((value) => true)
          .catchError((e)=>false);
      return check;
    }
  }

  Future<bool> checkCardsAlreadyFound(String cardNumber) async{
    if(fireStoreCards.doc().snapshots().length==0)
      return true;
    var stream = await fireStoreCards
        .where('userId',isEqualTo: signedINUser.id)
        .get();
    var finalstream = await stream.docs.where((element) => element["cardNumber"] == cardNumber);
    if(finalstream.length==0)
      return  true;
    return false;
  }

  Future getCards() async{
    var stream= await fireStoreCards.where('userId',isEqualTo: signedINUser.id).get();
    //List<CardModel> mycards = (json.decode(stream.docs.)as List).map((e) => CardModel.fromJson(e)).toList();
    List<CardModel> mycards = stream.docs.map((e) => CardModel.fromJson(e.data())).toList();
    return mycards;
  }

  Future<void> switchToCompletedState(String rid) async {
    return await _requestCollectionReference.doc(rid).update({
      'rideStatus': 'Completed',//CHANGE***********
    });
  }

  Future<void> switchToCancelledState(String requestId) async {
    return await _requestCollectionReference.doc(requestId).update({
      'rideStatus': 'Cancelled',//CHANGE***********
    });
  }

  Future<void> switchToDispatchedState(String requestId) async {
    return await _requestCollectionReference.doc(requestId).update({
      'rideStatus': 'Dispatched',//CHANGE***********
    });
  }

  validateEmail({required String email}) async {
    if(fireStoreUsers.doc().snapshots().length==0)
      return true;
    else {
      bool _final = true;
      var stream = await fireStoreUsers
          .where('email', isEqualTo: email)
          .get();
      print(stream.size);
      if (stream.size == 0) {
        _final = true;
      }
      else {
        _final = false;
      }
      return _final;
    }
  }

  Future saveAddress(AdressModel address)async{
   await firestoreAdresses.add({
      "label":address.adressTitle,
      "latitude":address.lat,
     "longitude":address.long
    }).then((value) => print(value.id)).catchError((e)=>print(e));
  }

  Future getAddress(String Adress)async{
    var stream =await firestoreAdresses.where(
      "label",isGreaterThanOrEqualTo: Adress
    ).get();
    List<AdressModel> model =  stream.docs.map((e) => AdressModel.fromJson(e.data())).toList();
    return model;
  }

  getDriver(String driverId) async {
     var driverDoc= await _driverCollectionReference.doc(driverId).get();
     late DriverModel driverDocument = DriverModel.fromJson(driverDoc.data()!);
   return driverDocument;
  }

  validatePhone(String phoneNo) async {
    if(fireStoreUsers.doc().snapshots().length==0)
      return true;
    else {
      bool _final = true;
    var stream = await fireStoreUsers
        .where('phoneNo', isEqualTo: phoneNo)
        .get();
    if (stream.size == 0) {
      _final = true;
    }
    else {
      _final = false;
    }
      return _final;
    }
  }

  Future<void> switchToOnGoingState(String requestId) async {
    return await _requestCollectionReference.doc(requestId).update({
      'rideStatus': 'OnGoing',//CHANGE***********
    });
  }

   getDriverDetails() async {
     DriverModel driverDocument = await getDriver(driverID);
    return driverDocument;
  }

  getRide(String requestId) async {
    var reqDocument= await _requestCollectionReference.doc(requestId).get();
    late RequestDataModel reqDoc =  RequestDataModel.fromJson(reqDocument.data()!);
    print("*****************${reqDoc.createDate}");
    return reqDoc;
  }
}