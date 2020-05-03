import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';

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
    getLocationData();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate called');
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    this.longitude = location.longitude;
    this.latitude = location.latitude;
    print('longitude: ${location.longitude} latitude:${location.latitude}');

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lon=$longitude&lat=$latitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();

    double temperature = weatherData['main']['temp'];
    int condition = weatherData['weather'][0]['id'];
    String city = weatherData['name'];
    print('temperature.$temperature condition.$condition city.$city');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
