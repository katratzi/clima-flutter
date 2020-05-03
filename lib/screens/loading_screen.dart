import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = 'e72ca729af228beabd5d20e3b7749713';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double longitude;
  double latitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate called');
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print('longitude: ${location.longitude} latitude:${location.latitude}');
    this.longitude = location.longitude;
    this.latitude = location.latitude;
    getData();
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lon=$longitude&lat=$latitude&appid=$apiKey');
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      var decodedData = jsonDecode(data);
      // temperature
      double temperature = decodedData['main']['temp'];
      // condition
      int condition = decodedData['weather'][0]['id'];
      // city name
      String city = decodedData['name'];
      print('temperature.$temperature condition.$condition city.$city');
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
