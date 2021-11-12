import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/adress_model.dart';
import 'package:bluetaxiapp/data/model/ride_model.dart';
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/data/model/vehicles_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/views/signin_signup_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:provider/provider.dart';

class AdressSelectionViewModel extends BaseModel {
   final AuthRepository authRepository;
   final UserModel signInUser;

  //varibles who are going to communicate with UI
  TextEditingController toController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  late String state;
  late String titleText;
  late bool test ;
  late List<AdressModel> adressList=[];
  late List<VehicleModel> vehiclesList = [];
  late RideModel generatedRide;

  //for disable button from list of vehicles in ride option state bottom sheet
  int vehicleSelectedIndex=0;

  AdressSelectionViewModel(  {required this.authRepository,required this.signInUser}):super(false) {
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
    vehicleSelectedIndex= newIndex;
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

   Future generateRequest() async{
     dynamic ans = await authRepository.generateRequest(
         userToken: signInUser.id,
         carType: vehiclesList[vehicleSelectedIndex].vName,
         expectedBill: "1000");
     if(ans!=null) generatedRide = ans;
   }
}
