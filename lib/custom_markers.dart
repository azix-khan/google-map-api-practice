import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  final Completer<GoogleMapController> _completer = Completer();
  Uint8List? markerImeges;
  List<String> images = [
    'images/man.png',
    'images/location-pin.png',
    'images/tracking.png',
    'images/user.png',
    'images/user1.png',
    'images/user2.png',
  ];
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLng = <LatLng>[
    const LatLng(33.6941, 72.9734),
    const LatLng(33.7008, 72.9682),
    const LatLng(33.6939, 72.9771),
    const LatLng(33.6910, 72.9807),
    const LatLng(33.992, 72.9744),
    const LatLng(33.7036, 72.9785),
  ];
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(33.6910, 72.98072), zoom: 14);

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon =
          await getBytesFromAssets(images[i].toString(), 100);
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: _latLng[i],
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(
              title: 'This is marker ' + i.toString(),
            )),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
        ),
      ),
    );
  }
}
