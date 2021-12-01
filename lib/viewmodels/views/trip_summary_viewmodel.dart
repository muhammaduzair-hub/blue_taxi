import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class TripViewModel extends BaseModel{
  late AuthRepository authRepository;
  final String driverId;
  final LatLng fromLatLng;
  final LatLng toLatLng;
  final String fromTitle;
  final String toTitle;

  late DriverModel? driverDocument;
  late Uint8List icPick;
  late Uint8List destinationMarker;
  late Uint8List currentLocationMarker;
  List<Marker> markers = [];



  TripViewModel({
      required this.fromLatLng,
      required this.toLatLng,
      required this.fromTitle,
      required this.toTitle,
      required this.authRepository,
      required this.driverId,

  }) : super(false) {
    getDriverr(driverId);
    driverDocument = DriverModel(id: '');
    loadCustomMarker();
  }


  Future<void> getDriverr(driverId) async {
    setBusy(true);
    driverDocument= await authRepository.getDriver(driverId);
    print(driverDocument!.driverName);
    setBusy(false);
  }


  void loadCustomMarker() async{
    setBusy(true);
    //carMaker = await getBytesFromAsset('asset/images/car_top.png', 100);
    currentLocationMarker = await getBytesFromAsset('asset/images/ic_loc.png', 100);
    destinationMarker = await getBytesFromAsset('asset/icons/flag.png', 50);
    icPick= await getBytesFromAsset('asset/images/ic_pick.png', 100);
    //carMaker=await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),"asset/images/car_top.png");
    setBusy(false);

    loadCurrentLocationMarler();
  }

  void loadCurrentLocationMarler(){
    addMarker(latLng: LatLng(	fromLatLng.latitude,fromLatLng.longitude),marker: currentLocationMarker, title: fromTitle);
    addMarker(latLng:LatLng(	fromLatLng.latitude,fromLatLng.longitude),marker: icPick, title: fromTitle);
    addMarker(latLng: LatLng(	toLatLng.latitude,toLatLng.longitude), marker: destinationMarker, title: toTitle);
    setBusy(false);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  void addMarker({required LatLng latLng, required Uint8List marker, required String title}){
    setBusy(true);
    markers.add(
      Marker(
          icon: BitmapDescriptor.fromBytes(marker),
          markerId: MarkerId((markers.length+1).toString()),
          position: latLng,
        infoWindow: InfoWindow(
          title: title
        )
      ),
    );
    setBusy(false);
  }
}