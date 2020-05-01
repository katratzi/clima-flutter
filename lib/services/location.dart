import 'package:geolocator/geolocator.dart';

class Location {
  double longitude;
  double latitude;

  Location({this.longitude, this.latitude});

  Future<void> getCurrentLocation() async {
    Position position;
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print(e);
    }

    // fallback - buckingham palace
    this.longitude = position.longitude ?? 51.5114;
    this.latitude = position.latitude ?? 0.1419;
  }
}
