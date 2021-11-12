import 'dart:async';
import 'dart:typed_data';

import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:geolocator/geolocator.dart';

class BookingViewModel extends BaseModel {
  late AuthRepository _authRepository;
  late BuildContext _context;

  //variables who are going to inttreact with ui
  late List<Marker> markers = [];
  late GoogleMapController googleMapController;
  late Uint8List icPick;
  late Uint8List carMarkerrr;
  late Uint8List currentLocationMarker;
  late Position currentLocation;
  late Completer<GoogleMapController> mapController = Completer();

  BookingViewModel({required AuthRepository authRepository,required BuildContext context}):super(false){
    _authRepository = authRepository;
    _context = context;
    //loading Custom marker of car
    getCurrentLocation();
    loadCustomMarker();
  }

  void loadCustomMarker() async{
    setBusy(true);
    //carMaker = await getBytesFromAsset('asset/images/car_top.png', 100);
    currentLocationMarker = await getBytesFromAsset('asset/images/ic_loc.png', 300);
    carMarkerrr= await getBytesFromAsset('asset/images/car_top.png', 200);
    icPick= await getBytesFromAsset('asset/images/ic_pick.png', 100);
    //carMaker=await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),"asset/images/car_top.png");
    setBusy(false);
    addMarker(latLng: LatLng(	33.738045,73.084488),marker: carMarkerrr);
    loadCurrentLocationMarler();
  }

  void loadCurrentLocationMarler(){
    if(currentLocation!=null){
      addMarker(latLng: LatLng(	currentLocation.latitude,currentLocation.longitude),marker: currentLocationMarker);
      addMarker(latLng: LatLng(currentLocation.latitude,currentLocation.longitude),marker: icPick);
    }

  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  void addMarker({required LatLng latLng, required Uint8List marker}){
    setBusy(true);
    markers.add(
      Marker(
        icon: BitmapDescriptor.fromBytes(marker),
        markerId: MarkerId((markers.length+1).toString()),
        position: latLng
      ),
    );
    setBusy(false);
  }


  //Map Work
  Future<void> goToPositone() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(currentLocation.latitude,currentLocation.longitude),
              zoom: 12,
              tilt: 59.440
            )
        )
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

  Future getCurrentLocation() async{
    currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }



}
