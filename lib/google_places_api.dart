import 'package:flutter/material.dart';

class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({super.key});

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Google Search Places Api'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
