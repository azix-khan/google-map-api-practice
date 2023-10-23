import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({super.key});

  @override
  State<ConvertLatLangToAddress> createState() =>
      _ConvertLatLangToAddressState();
}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {
  String stAddress = '';
  String stAdd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convert LatLang To Address'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),
          GestureDetector(
            onTap: () async {
              List<Location> locations =
                  await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks =
                  await placemarkFromCoordinates(52.2165157, 6.9437819);

              setState(() {
                // ignore: prefer_interpolation_to_compose_strings
                stAddress = locations.last.latitude.toString() +
                    " " +
                    locations.last.longitude.toString();
                // ignore: prefer_interpolation_to_compose_strings
                stAdd = placemarks.reversed.last.country.toString() +
                    " " +
                    placemarks.reversed.last.locality.toString();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(color: Colors.green),
                child: const Center(
                  child: Text('Convert'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
