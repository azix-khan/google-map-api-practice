import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({super.key});

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {
  TextEditingController _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '12345';
  List<dynamic> _placesList = [];
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      onChanged();
    });
  }

  void onChanged() {
    // ignore: unnecessary_null_comparison
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    // NOTE: add your api below
    String kPLACES_API_KEY = 'YOur Api key';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Faild to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Google Search Places Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Search Place here'),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _placesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    List<Location> locations = await locationFromAddress(
                        _placesList[index]['description']);
                    print(locations.last.latitude);
                    print(locations.last.longitude);
                  },
                  title: Text(_placesList[index]['description']),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
