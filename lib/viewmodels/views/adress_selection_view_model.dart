import 'dart:async';
import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/adress_model.dart';
import 'package:bluetaxiapp/data/model/card_model.dart';
import 'package:bluetaxiapp/data/model/vehicles_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdressSelectionViewModel extends BaseModel {
   final AuthRepository authRepository;

  //varibles who are going to communicate with UI
  TextEditingController toController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  late String state;
  late String titleText;
  late List<Marker> markers=[];
  late List<AdressModel> adressList=[];
  late List<AdressModel> remoteAdressList=[];
  late List<VehicleModel> vehiclesList = [];
  late List<String> localAdressTitles=[];
  late List<String> remoteAdressTitle= [];
  late AdressModel from ;
  late AdressModel to;
  late double distance;
  late String generatedRide;
  late int addressSelection_FromSearchTextFieldInitialSize;
   late int addressSelection_ToSearchTextFieldInitialSize;
   final debouncer = Debouncer(milliseconds: 3000);
   late Map<String, List> groupList ;
   bool selectedfromTextField = true;
   late List<CardModel> myCards=[];
   late int selectedCardIndex =0;

  //for disable button from list of vehicles in ride option state bottom sheet
  int vehicleSelectedIndex=0;

   AdressSelectionViewModel( {required this.authRepository}):super(false) {
     state = LabelSelectAdress;
     addressSelection_FromSearchTextFieldInitialSize = 25;
     addressSelection_ToSearchTextFieldInitialSize = 25;
     getAllAdress();
     getAllVehiclesLocally();
     getcards();
     initializegroupList(localAdressTitles);
   }

   switchSelectCardIndex(int index){
     selectedCardIndex = index;
     setBusy(false);
   }

  switchTextField(){
    selectedfromTextField = false;
    setBusy(false);
  }

  showonMap() async{

    try{
     from = adressList.firstWhere((element) => element.adressTitle == fromController.text);
    }catch(e){
      from = remoteAdressList.firstWhere((element) => element.adressTitle == fromController.text);
    }
    try{
      to = adressList.firstWhere((element) => element.adressTitle == toController.text);
    }catch(e){
      to = remoteAdressList.firstWhere((element) => element.adressTitle == toController.text);
    }
    distance = await Geolocator.distanceBetween(to.lat, to.long, from.lat, from.long);
    distance=distance/1000;
    addMarkers(LatLng(from.lat, from.long), "From", "$distance KM");
    addMarkers(LatLng(to.lat, to.long), "To", "$distance KM");

    setBusy(false);
  }

   getcards()async{
     setBusy(true);
     myCards.add(
       CardModel(leadingImage: AssetImage('asset/icons/ic_cash.png'), cardNumber: "Cash",),
     );
     myCards.addAll(await authRepository.api.getCards());
     setBusy(false);
   }

  addMarkers(LatLng latLng, String description, String distance){
    markers.add(
      Marker(
        markerId: MarkerId(markers.length.toString()),
        position: latLng,
        infoWindow: InfoWindow(
          title: description,
          snippet: distance
        )
      )
    );
    setBusy(false);
  }



  initializegroupList(List<String> local){
    groupList = {
      if(remoteAdressTitle.isNotEmpty)'Search Result':remoteAdressTitle,
      if(localAdressTitles.isNotEmpty)'Recent':localAdressTitles
    };
  }

  switchState(String newstate){
    setBusy(true);
    state =newstate;
    print(state);
    setBusy(false);
  }

  switchSearchFieldSize(String state,int newSize){
    if(state=="from") addressSelection_FromSearchTextFieldInitialSize = newSize;
    else addressSelection_ToSearchTextFieldInitialSize = newSize;
    setBusy(false);
  }
  selectSearchItem(TextEditingController controller,String item){
    controller.text = item;
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
    adressList.forEach((element) {
      localAdressTitles.add(element.adressTitle);
    });
    initializegroupList(localAdressTitles);
    print("There are ${localAdressTitles.length} addresses");
    setBusy(false);
  }

  getAllVehiclesLocally() async{
    vehiclesList =await authRepository.getVehiclesLocally();
  }

   Future generateRequest() async{
     dynamic ans = await authRepository.generateRequest(
         userToken: signedINUser.id,
         carType: vehiclesList[vehicleSelectedIndex].vName,
         expectedBill: "1000",
         toAdress: to,
         fromAdress: from,
         card: myCards[selectedCardIndex],
     );

     if(ans!=null){
       requestId=ans;
       generatedRide = ans;}
     print(generatedRide);
   }


   searchAdressOnTextField(String val) async {
    setBusy(true);
    try{
      adressList.firstWhere((element) => element.adressTitle == val);

      List<String> localTemp=[];
      localAdressTitles.forEach((element) {
        if(element.contains(val))localTemp.add(element);
      });
      initializegroupList(localTemp);
    }catch(e){

      List<AdressModel> res =await authRepository.getAdressRemote(adress: val);
      remoteAdressList.addAll(res);
      remoteAdressTitle =[];
       res.forEach((element) {
         remoteAdressTitle.add(element.adressTitle);});
       List<String> localTemp=[];
       localAdressTitles.forEach((element) {
         if(element.contains(element))
           localTemp.add(element);
       });
       initializegroupList(localTemp);
    }
    setBusy(false);
   }



}

class Debouncer {
  final int milliseconds;
  late VoidCallback action;
   Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}