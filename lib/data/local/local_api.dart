
import 'package:bluetaxiapp/data/local/local_db/user_database.dart';
import 'package:bluetaxiapp/data/model/adress_model.dart';
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/model/vehicles_model.dart';

import 'local_db/adress_database.dart';


class LocalApi{
  List<AdressModel> adressList =[];
  List<UserModel> loginUser =[];
  List<VehicleModel> vehicalList= [
    new VehicleModel(vName: "Standard", vid: 1, vPic: 'asset/icons/standard.png', vRate: "\$5", vArrivingTime: "3 min"),
    new VehicleModel(vName: "Van", vid: 2, vPic: 'asset/icons/van (1).png', vRate: "\$9", vArrivingTime: "5 min"),
    new VehicleModel(vName: "Exec", vid: 3, vPic: 'asset/icons/exec.png', vRate: "\$7", vArrivingTime: "6 min"),
    new VehicleModel(vName: "Electric ", vid: 4, vPic: 'asset/icons/electric.png', vRate: "\$5", vArrivingTime: "3 min"),
    new VehicleModel(vName: "Eco", vid: 5, vPic: 'asset/icons/eco.png', vRate: "\$7", vArrivingTime: "7 min"),
    new VehicleModel(vName: "Access", vid: 6, vPic: 'asset/icons/access.png', vRate: "\$5", vArrivingTime: "3 min"),
  ];

  LocalApi(){
    refreshAdresses();
    refreshLoginUSer();
  }

  void refreshAdresses() async{
    adressList = await AdressDatabase.instance.readAllNotes();
  }
  
  void refreshLoginUSer() async{
    loginUser = await UserDatabase.instance.readAllNotes();
  }

  Future<List<AdressModel>> readAllAdresses() async{
    adressList = await AdressDatabase.instance.readAllNotes();
    return adressList;
  }

  Future<List<AdressModel>> addAdress ({required String title}) async{
    AdressModel taskModel = AdressModel(adressTitle: title);
    await AdressDatabase.instance.create(taskModel);
    adressList = await AdressDatabase.instance.readAllNotes();
    return adressList;
  }

  Future<bool> test()async{
    print("Succesfully");
    await Future.delayed(Duration(milliseconds: 1000));
    return true;
  }

  Future addLoginPerson(UserModel user) async{
    await UserDatabase.instance.create(user);
  }
  Future<UserModel> getAlreadySignIn() async{
    loginUser = await UserDatabase.instance.readAllNotes();
    return loginUser.length>0?loginUser[0]:UserModel(id: '');
  }
}


