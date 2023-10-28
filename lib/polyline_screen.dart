import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  final Completer<GoogleMapController> _completer = Completer();
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(34.012833, 71.595359), zoom: 14);

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  List<LatLng> latlng = [
    const LatLng(34.012833, 71.595359),
    const LatLng(34.098586, 70.991536),
    const LatLng(34.611159, 73.096881),
    const LatLng(33.521576, 72.991358),
    const LatLng(34.078552, 73.438007),
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < latlng.length; i++) {
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: latlng[i],
            infoWindow: const InfoWindow(
              title: 'Really cool place',
              snippet: '5 star hotel',
            ),
            icon: BitmapDescriptor.defaultMarker),
      );
      setState(() {});

      _polyline.add(Polyline(
        polylineId: PolylineId('1'),
        points: latlng,
        color: Colors.orange,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polylines'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: _markers,
        mapType: MapType.normal,
        myLocationEnabled: true,
        polylines: _polyline,
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
      ),
    );
  }
}
