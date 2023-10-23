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
      position: LatLng(37.4219983, -122.084),
      infoWindow: InfoWindow(title: 'My Current Position'),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(33.720000, 73.060000),
      infoWindow: InfoWindow(title: 'Deans'),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(36.2048, 138.2529),
      infoWindow: InfoWindow(title: 'Japan'),
    ),
    Marker(
      markerId: MarkerId('4'),
      position: LatLng(38.9637, 35.2433),
      infoWindow: InfoWindow(title: 'Turkey'),
    ),
    Marker(
      markerId: MarkerId('5'),
      position: LatLng(61.5240, 105.3188),
      infoWindow: InfoWindow(title: 'Russia'),
    ),
    Marker(
      markerId: MarkerId('6'),
      position: LatLng(40.741895, -73.989308),
      infoWindow: InfoWindow(title: 'New York'),
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
      body: SafeArea(
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          mapType: MapType.normal,
          compassEnabled: true,
          myLocationEnabled: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.my_location),
          onPressed: () async {
            GoogleMapController controller = await _completer.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                const CameraPosition(
                    target: LatLng(40.741895, -73.989308), zoom: 14),
              ),
            );
            setState(() {});
          }),
    );
  }
}
