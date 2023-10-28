import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({super.key});

  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {
  final Completer<GoogleMapController> _completer = Completer();
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(34.012833, 71.595359), zoom: 14);

  final Set<Polygon> _polygone = HashSet<Polygon>();

  List<LatLng> points = [
    const LatLng(34.012833, 71.595359),
    const LatLng(34.098586, 70.991536),
    const LatLng(34.611159, 73.096881),
    const LatLng(33.521576, 72.991358),
    const LatLng(34.078552, 73.438007),
    const LatLng(34.012833, 71.595359),
  ];

  @override
  void initState() {
    super.initState();
    _polygone.add(
      Polygon(
        polygonId: const PolygonId('1'),
        points: points,
        fillColor: Colors.red.withOpacity(0.3),
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.deepOrange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygone'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        polygons: _polygone,
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
      ),
    );
  }
}
