import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');


  // user data from snapshots
  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
        id: uid,
        name: (snapshot.data() as dynamic)['name'],//(snapshot.data() as dynamic)['name']
        email: (snapshot.data() as dynamic)['email'],
        phoneno: (snapshot.data() as dynamic)['phoneno']
    );
  }

  // get user doc stream
  Stream<UserModel> get userData {
    return userCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }
//User data via Registration Updating
  Future<void> addUserData(String name, String email, String phoneNo, String password, String address, String type) async {
    print(name+email+phoneNo+password);
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'password': password,
      'address':address,
      'type':type,
    });
  }

}