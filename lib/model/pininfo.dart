import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinInformation {
  String userId;
  String name;
  String phone;
  double rating;
  String houseNo;
  LatLng location;
  PinInformation({
    required this.userId,
    required this.name,
    required this.phone,
    required this.rating,
    required this.houseNo,
    required this.location,
  });
}
