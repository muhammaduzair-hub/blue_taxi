import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ArrivingSelectionViewModel extends BaseModel {
  final AuthRepository repo;
  late String state;
  final firestoreDriver = FirebaseFirestore.instance.collection("driver");


  ArrivingSelectionViewModel({required this.repo}) {

    state=LabelSearching;
    Future.delayed(Duration(seconds: 1), () {
      switchState(LabelArriving);
    });
  }

  switchState(String newstate){
    setBusy(true);
    state =newstate;
    // if(newstate==LabelArriving){
    //   Future.delayed(Duration(seconds: 5), () {
    //     switchState(LabelArrived);
    //   });
    // }
    setBusy(false);
  }

  String switchRateLabel(double rating){
    String rated="Excellent";
    setBusy(true);

    if(rating == 1.0)
      rated="Very Bad";
    else if(rating == 2.0)
      rated="Bad";
    else if(rating == 3.0)
      rated="Good";
    else if(rating == 4.0)
      rated="Very Good";
    else if(rating == 5.0)
      rated="Excellent";
    setBusy(false);
    return rated;
  }

  Future getRequestId(String requestId) async{
    dynamic result=FirebaseFirestore.instance.collection('request').doc(requestId).get();
    print(result);
    assignDriver();
    return result;
  }

  Future assignDriver() async {
      var stream = await firestoreDriver
          .where('driverStatus', isEqualTo: 0)
          .get()
          .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((element) {
              print(element["driverStatus"]);
            });
          }
      );

      if(stream.size==1){
        print("*********************GOT THE OBJECT**********"+stream.toString());
        return  true;
      }
      print("*******************STREAM SIZE********** "+stream.size.toString());
      return false;
  }
}