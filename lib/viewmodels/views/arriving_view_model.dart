import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/request_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';


class ArrivingSelectionViewModel extends BaseModel {
  final AuthRepository repo;
  late String state;

  final _requestCollectionReference =
  FirebaseFirestore.instance.collection("request");

  final _driverCollectionReference =
  FirebaseFirestore.instance.collection("driver");


  ArrivingSelectionViewModel({required this.repo}) : super(false) {
    state = LabelSearching;
    Future.delayed(Duration(seconds: 1), () {
      switchState(LabelArriving);
    });
  }

  switchState(String newstate) {
    setBusy(true);
    state = newstate;
    // if(newstate==LabelArriving){
    //   Future.delayed(Duration(seconds: 5), () {
    //     switchState(LabelArrived);
    //   });
    // }
    setBusy(false);
  }

  String switchRateLabel(double rating) {
    String rated = "Excellent";
    setBusy(true);

    if (rating == 1.0)
      rated = "Very Bad";
    else if (rating == 2.0)
      rated = "Bad";
    else if (rating == 3.0)
      rated = "Good";
    else if (rating == 4.0)
      rated = "Very Good";
    else if (rating == 5.0)
      rated = "Excellent";
    setBusy(false);
    return rated;
  }

  Future getRequest(String uid) async {
    try{
      dynamic driverID = await getActiveDriver();
      var requestData = await _requestCollectionReference.doc(uid).get()
          .whenComplete(() async {
        await updateRequestData(uid, driverID);
      });


      print(requestData.data().toString());
      //requestData.data()!.update('riderId', (driverID) => driverID);





      RequestModel RequestGot = new RequestModel.fromJson(requestData.data(), uid, driverID);

      print(RequestGot.expectedBill);
      print(RequestGot.id);
      print(RequestGot.toAddress);
      print(RequestGot.userId);
      print(RequestGot.rideStatus);
      print(RequestGot.riderId);
      print(RequestGot.fromAddress);
      print(RequestGot.carType);
      print(RequestGot.paymentMethod);

      return RequestGot;

    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }


  Future<void> updateRequestData(String rid, String driverId) async {
    return await _requestCollectionReference.doc(rid).update({
      'riderId': driverId,
      'rideStatus': 1,
    });
  }

  Future getActiveDriver() async {
    var driverId;
    try {
      //Getting any driver in INACTIVE STATE (0),
      // Changing Driver Status to 1 and assigning him to Request
      var dData = await _driverCollectionReference.where('driverStatus' , isEqualTo: 0)
          .limit(1)
          .get()
          .then((value) =>
          value.docs.forEach((doc)=> {
            print(doc['driverName']),
            doc.reference.update({'driverStatus' : 1}),
            driverId= doc.id,
            print(driverId),
          })
      );
      return driverId;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

}