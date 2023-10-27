import 'package:flutter/material.dart';

class CustomMarkerInfoWindowScreen extends StatefulWidget {
  const CustomMarkerInfoWindowScreen({super.key});

  @override
  State<CustomMarkerInfoWindowScreen> createState() =>
      _CustomMarkerInfoWindowScreenState();
}

class _CustomMarkerInfoWindowScreenState
    extends State<CustomMarkerInfoWindowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Marker Info Window'),
      ),
      body: Stack(
        children: [],
      ),
    );
  }
}
