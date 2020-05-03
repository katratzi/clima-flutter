import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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
  }

  void getData() async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02');
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
    getData();
    return Scaffold();
  }
}
