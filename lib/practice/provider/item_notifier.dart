import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class ItemAddNotifier extends ChangeNotifier {

  final List<Marker> markerList = <Marker>[];
  addMarker(Marker) async {
    markerList.add(Marker);
    notifyListeners();
  }
}