
import 'package:bluetaxiapp/provider_practice/data/db_files/user_dto_database.dart';
import 'package:bluetaxiapp/provider_practice/data/model/user_dto.dart';
import 'package:flutter/cupertino.dart';

class UserDTOState extends ChangeNotifier{
  List<UserDTO> usersList =[];

  UserDTOState(){
    getAllUsers();
  }
  Future getAllUsers() async{
    usersList = await UserDTODatabase.instance.readAllNotes();
    notifyListeners();
  }

  addUser({required UserDTO newUser}) async {
    await UserDTODatabase.instance.create(newUser);
    usersList.clear();
    getAllUsers();
  }

}