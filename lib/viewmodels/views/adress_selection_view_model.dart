import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/adress_model.dart';
import 'package:bluetaxiapp/data/model/vehicles_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class AdressSelectionViewModel extends BaseModel {
   final AuthRepository authRepository;

  //varibles who are going to communicate with UI
  TextEditingController toController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  late String state;
  late String titleText;
  late bool test ;
  late List<AdressModel> adressList=[];
  late List<VehicleModel> vehiclesList = [];

  //for disable button from list of vehicles in ride option state bottom sheet
  int index=0;

  AdressSelectionViewModel({required this.authRepository}):super(false) {
    state = LabelSelectAdress;
    getAllAdress();
    getAllVehiclesLocally();
  }

  switchState(String newstate){
    setBusy(true);
    state =newstate;
    print(state);
    setBusy(false);
  }

  switchRideOptionButtonIndex(int newIndex){
    setBusy(true);
    index= newIndex;
    setBusy(false);
  }

  addAdress(String adress)async {
    setBusy(true);
    try{
       adressList.firstWhere((element) => element.adressTitle == adress);
    }catch(e){
      adressList =await authRepository.addAdressLocally(adress: adress);
    }
    setBusy(false);
  }

  getAllAdress() async{
    setBusy(true);
    adressList = await authRepository.getAdressLocally();
    setBusy(false);
  }

  getAllVehiclesLocally() async{
    vehiclesList =await authRepository.getVehiclesLocally();
  }
}
