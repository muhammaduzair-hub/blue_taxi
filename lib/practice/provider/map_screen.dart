import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'item_notifier.dart';

class MapClass extends StatelessWidget {
  MapClass({Key? key}) : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();
  

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: Consumer<ItemAddNotifier>(
          builder: (context, value, child) {
            return GoogleMap(
              zoomControlsEnabled: true,
              mapType: MapType.terrain,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: const CameraPosition(
                  target: LatLng(33.6158004, 72.8059198), zoom: 11),
              markers: Set.of(value.markerList),

              //To listen to user's Tap on google map
              onTap: (LatLng latLng) async {
                // you have latitude and longitude here
                var latitude = latLng.latitude;
                var longitude = latLng.longitude;
                //Implement this via Consumer
                await value
                    .addMarker(Marker(
                  markerId: MarkerId("1"),
                  infoWindow: InfoWindow(title: "Title", snippet: "Snippet"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueMagenta),
                  position: LatLng(latitude, longitude),
                ));
              },

            );
          } ,
        ),
    );
  }
}
