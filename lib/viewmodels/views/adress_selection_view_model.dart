import 'dart:async';
import 'dart:typed_data';
import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/adress_model.dart';
import 'package:bluetaxiapp/data/model/card_model.dart';
import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/data/model/vehicles_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

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
  late double bill;
  late String generatedRide;
  late int addressSelection_FromSearchTextFieldInitialSize;
   late int addressSelection_ToSearchTextFieldInitialSize;
   final debouncer = Debouncer(milliseconds: 3000);
   late Map<String, List> groupList ;
   bool selectedfromTextField = true;
   bool checkToTextFieldval = false;
   late List<CardModel> myCards=[];
   late int selectedCardIndex =0;
   List<String> selectedAddresses = [];
   late Uint8List icPick;
   late Uint8List destinationMarker;
   final Key adressSelectionKey=Key("AdressSelection");
   final Key othersSheetKey  = Key("Other");
   final Key cardSheet = Key("Card");


  //for disable button from list of vehicles in ride option state bottom sheet
  int vehicleSelectedIndex=0;

   AdressSelectionViewModel( {required this.authRepository}):super(false) {
     loadCustomMarker();
     state = LabelSelectAdress;
     addressSelection_FromSearchTextFieldInitialSize = 25;
     addressSelection_ToSearchTextFieldInitialSize = 25;
     getAllAdress();
     getAllVehiclesLocally();
     getcards();
     initializegroupList(localAdressTitles);
   }

   void loadCustomMarker() async{
     setBusy(true);
     //carMaker = await getBytesFromAsset('asset/images/car_top.png', 100);

     destinationMarker = await getBytesFromAsset('asset/icons/flag.png', 100);
     icPick= await getBytesFromAsset('asset/icons/loader.png', 150);
     //carMaker=await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),"asset/images/car_top.png");
     setBusy(false);


   }

   Future<Uint8List> getBytesFromAsset(String path, int width) async {
     ByteData data = await rootBundle.load(path);
     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
     ui.FrameInfo fi = await codec.getNextFrame();
     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
   }

   switchSelectCardIndex(int index){
     selectedCardIndex = index;
     setBusy(false);
   }

  switchTextField(){
    selectedfromTextField = false;
    setBusy(false);
  }
   checkFromTextField(){
     try{
       localAdressTitles.firstWhere((element) => element==fromController.text);
       selectedfromTextField = true;
     }catch(e){
       try{
         remoteAdressTitle.firstWhere((element) => element==fromController.text);
         selectedfromTextField = true;
       }
       catch(e){
         try{
           selectedAddresses.firstWhere((element) => element==fromController.text);
           selectedfromTextField = true;
         }
         catch(e){
           selectedfromTextField = false;
         }
       }
     }
     setBusy(false);
   }
  checkToTextField(){
     try{
       localAdressTitles.firstWhere((element) => element==toController.text);
       checkToTextFieldval = true;
     }catch(e){
       try{
         remoteAdressTitle.firstWhere((element) => element==toController.text);
         checkToTextFieldval = true;
       }
       catch(e){
         try{
           selectedAddresses.firstWhere((element) => element==toController.text);
           checkToTextFieldval = true;
         }
         catch(e){
           checkToTextFieldval = false;
         }
       }
     }
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
    bill = distance*3;
    addMarkers(LatLng(from.lat, from.long), "From", "$distance KM", icPick);
    addMarkers(LatLng(to.lat, to.long), "To", "$distance KM", destinationMarker);

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

  addMarkers(LatLng latLng, String description, String distance, Uint8List marker){
    markers.add(
      Marker(
          icon: BitmapDescriptor.fromBytes(marker),
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
     requestId = await authRepository.generateRequest(
         userToken: signedINUser.id,
         carType: vehiclesList[vehicleSelectedIndex].vName,
         expectedBill: "1000",
         toAdress: to,
         fromAdress: from,
         card: myCards[selectedCardIndex],
          bill : (bill.toInt()).toDouble()
     );

     print("here it is answer: $requestId");

   }


   getDriverDetails()async {
     setBusy(true);
     print("Checking Driver ");
     dynamic driverModel  =await authRepository.getDriverDetails();
     setBusy(false);
     return driverModel;
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
      if(remoteAdressTitle.isEmpty&&localAdressTitles.isEmpty) showToast("Enter Correct Address");
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