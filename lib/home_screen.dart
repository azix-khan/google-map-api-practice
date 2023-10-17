import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _completer = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.006962, 71.533058),
    zoom: 14.4746,
  );
  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(34.006962, 71.533058),
      infoWindow: InfoWindow(title: 'My Current Position'),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(33.720000, 73.060000),
      infoWindow: InfoWindow(title: 'Deans'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        mapType: MapType.normal,
        compassEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }
}
