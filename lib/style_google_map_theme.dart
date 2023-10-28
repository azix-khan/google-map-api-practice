import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapThemeScreen extends StatefulWidget {
  const StyleGoogleMapThemeScreen({super.key});

  @override
  State<StyleGoogleMapThemeScreen> createState() =>
      _StyleGoogleMapThemeScreenState();
}

class _StyleGoogleMapThemeScreenState extends State<StyleGoogleMapThemeScreen> {
  String mapTheme = '';
  final Completer<GoogleMapController> _completer = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6941, 72.9734),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/standard_theme.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Theme'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  _completer.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/maptheme/standard_theme.json')
                        .then((string) {
                      value.setMapStyle(string);
                    });
                  });
                },
                child: const Text('Standard'),
              ),
              PopupMenuItem(
                onTap: () {
                  _completer.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/maptheme/silver_theme.json')
                        .then((string) {
                      value.setMapStyle(string);
                    });
                  });
                },
                child: const Text('Silver'),
              ),
              PopupMenuItem(
                onTap: () {
                  _completer.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/maptheme/retro_theme.json')
                        .then((string) {
                      value.setMapStyle(string);
                    });
                  });
                },
                child: const Text('Retro'),
              ),
              PopupMenuItem(
                onTap: () {
                  _completer.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('assets/maptheme/night_theme.json')
                        .then((string) {
                      value.setMapStyle(string);
                    });
                  });
                },
                child: const Text('Night'),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(mapTheme);
            _completer.complete(controller);
          },
        ),
      ),
    );
  }
}
