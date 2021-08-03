import 'package:google_maps_flutter/google_maps_flutter.dart';

class Profile {
  final String houseNo;
  final String address;
  final LatLng geoPoint;
  final double rating;
  final String schedule;
  final String selectedCollector;
  final double disposedAmount;

  Profile(
      {required this.houseNo,
      required this.address,
      required this.geoPoint,
      required this.rating,
      required this.schedule,
      required this.selectedCollector,
      required this.disposedAmount});

  Profile.fromJson(Map<String, dynamic> json)
      : this(
            houseNo: json['houseNo']! as String,
            address: json['address']! as String,
            geoPoint: json['geoPoint']! as LatLng,
            rating: json['rating']! as double,
            schedule: json['schedule']! as String,
            selectedCollector: json['selectedCollector'] as String,
            disposedAmount: json['disposedAmount']! as double);

  Map<String, Object?> toJson() {
    return {
      'houseNo': houseNo,
      'address': address,
      'geoPoint': geoPoint,
      'rating': rating,
      'schedule': schedule,
      'disposedAmount': disposedAmount,
      'selectedCollector': selectedCollector,
    };
  }
}
