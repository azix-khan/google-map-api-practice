import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLoctionScreen extends StatefulWidget {
  const GetUserCurrentLoctionScreen({super.key});

  @override
  State<GetUserCurrentLoctionScreen> createState() =>
      _GetUserCurrentLoctionScreenState();
}

class _GetUserCurrentLoctionScreenState
    extends State<GetUserCurrentLoctionScreen> {
  final Completer<GoogleMapController> _completer = Completer();
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(33.720000, 73.060000), zoom: 14);

  final List<Marker> _marker = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(33.720000, 73.060000),
      infoWindow: InfoWindow(title: 'The title of the marker'),
    ),
  ];

  loadLocation() {
    getUserCurrentLocation().then((value) async {
      print('My Current location');
      print(value.latitude.toString() + " " + value.longitude.toString());

      _marker.add(
        Marker(
            markerId: const MarkerId('2'),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(
              title: 'My Current Location',
            )),
      );
      CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(value.latitude, value.longitude),
      );
      final GoogleMapController controller = await _completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('Error ' + error.toString());
    });
    return Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    loadLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getUserCurrentLocation().then((value) async {
            print('My Current location');
            print(value.latitude.toString() + " " + value.longitude.toString());

            _marker.add(
              Marker(
                  markerId: const MarkerId('2'),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(
                    title: 'My Current Location',
                  )),
            );
            CameraPosition cameraPosition = CameraPosition(
              zoom: 14,
              target: LatLng(value.latitude, value.longitude),
            );
            final GoogleMapController controller = await _completer.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: const Icon(Icons.location_searching_rounded),
      ),
    );
  }
}
