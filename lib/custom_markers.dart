import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  final Completer<GoogleMapController> _completer = Completer();
  List<String> images = [];
  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latLng = <LatLng>[
    const LatLng(34.017531, 71.535026),
    const LatLng(34.013554, 71.518961),
    const LatLng(34.019952, 71.519378),
    const LatLng(34.017263, 71.527387),
    const LatLng(34.014320, 71.523665),
    const LatLng(34.017291, 71.525078),
  ];
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(33.6910, 72.98072), zoom: 14);
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
