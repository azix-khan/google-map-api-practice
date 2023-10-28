import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageCustomMarkerScreen extends StatefulWidget {
  const NetworkImageCustomMarkerScreen({super.key});

  @override
  State<NetworkImageCustomMarkerScreen> createState() =>
      _NetworkImageCustomMarkerScreenState();
}

class _NetworkImageCustomMarkerScreenState
    extends State<NetworkImageCustomMarkerScreen> {
  final Completer<GoogleMapController> _completer = Completer();

  List<String> images = [
    'images/man.png',
    'images/location-pin.png',
    'images/tracking.png',
    'images/user.png',
    'images/user1.png',
    'images/user2.png',
  ];

  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLng = [
    const LatLng(33.6941, 72.9734),
    const LatLng(33.7008, 72.9682),
    const LatLng(33.6992, 72.9744),
    const LatLng(33.6939, 72.9771),
    const LatLng(33.6910, 72.9807),
    const LatLng(33.7036, 72.9785)
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6941, 72.9734),
    zoom: 15,
  );

// to load custom image from assets

  // Future<Uint8List> getBytesFromAssets(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetHeight: 60);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
  //       .buffer
  //       .asUint8List();
  // }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      // calling loadnetworkimage
      Uint8List? image = await _loadNetworkImage(
          'https://images.bitmoji.com/3d/avatar/201714142-99447061956_1-s5-v1.webp');

      final ui.Codec markerImageCodec = await instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 200,
        targetWidth: 200,
      );
      final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ImageByteFormat.png,
      );
// to resize network image
      final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _latLng[i],
        icon: BitmapDescriptor.fromBytes(resizedMarkerImageBytes),
        anchor: const Offset(.1, .1),
        //icon: BitmapDescriptor.fromBytes(image!.buffer.asUint8List()),
        infoWindow: InfoWindow(title: 'This is title marker: ' + i.toString()),
      ));
      setState(() {});
    }
  }

// to load network image
  Future<Uint8List?> _loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img
        .resolve(const ImageConfiguration(size: Size.fromHeight(10)))
        .addListener(
            ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData?.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
        ),
      ),
    );
  }
}
