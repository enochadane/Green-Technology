import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firestore_example/model/user.dart';
import 'package:flutter_firestore_example/model/pininfo.dart';
import 'package:flutter_firestore_example/services/user_services.dart';
import 'package:flutter_firestore_example/utils/auth_provider.dart';
import 'package:flutter_firestore_example/utils/my_theme.dart';
import 'package:flutter_firestore_example/widgets/map/map_pill.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:provider/provider.dart';

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class MapPage extends StatefulWidget {
  static const String routeName = "/map";
  UserServices _userServices = new UserServices();
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  LatLng initialLocation = LatLng(9.301392211274675, 39.78237001138305);
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  late BitmapDescriptor markerIcon;
  double pinPillPosition = -100;
  late String _mapStyleDark;
  late String _mapStyleLight;
  late List<User> users;

  PinInformation currentlySelectedPin = PinInformation(
      houseNo: "3433",
      phone: "+322323",
      rating: 3.5,
      location: LatLng(9.201392211274675, 39.78237001138305),
      name: 'username',
      userId: "232323");

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/styles/map_dark_style.txt').then((string) {
      _mapStyleDark = string;
    });
    rootBundle.loadString('assets/styles/map_light_style.txt').then((string) {
      _mapStyleLight = string;
    });
    setMarkersIcons();
  }

  Future<List<User>> getUsers() async {
    var usersOld = await widget._userServices.getNormalUsers();
    var uusers = usersOld.asMap().entries.map((e) {
      var prof = e.value['profile'] as Map<String, dynamic>;
      return new User(
        uid: e.key.toString(),
        name: e.value["name"] as String,
        phone: e.value["phone"] as String,
        password: "password",
        profile: {
          "houseNo": prof["houseNo"] as String,
          "address": prof["phone"] as String,
          "latLng": new LatLng(prof["latitude"], prof["longitude"]),
          "rating": prof["rating"] as double,
        },
        comments: [],
        role: e.value["role"] as String,
      );
    }).toList();
    print("how it comes $uusers");
    return uusers;
  }

  Future<Position> getCurrentLocation() async {
    await Geolocator.checkPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      this.initialLocation = LatLng(position.latitude, position.longitude);
      print("getting current location ${this.initialLocation}");
    });

    setMarkersIcons();
    await setMapPins();
    return position;
  }

  // List<User> users = [
  //   new User(
  //       uid: "890707",
  //       name: "Nathaniel Awel",
  //       phone: "+0923343443",
  //       password: "password",
  //       profile: {
  //         "houseNo": "314",
  //         "address": "Hawassa, Ethiopia",
  //         "latLng": new LatLng(9.001392211274675, 38.78237001138305),
  //         "rating": 4.5,
  //       },
  //       comments: [],
  //       role: "role"),
  //   new User(
  //       uid: "345676",
  //       name: "Henok Adane",
  //       phone: "+2593343434",
  //       password: "password",
  //       profile: {
  //         "houseNo": "235",
  //         "address": "Hosana, Ethiopia",
  //         "latLng": new LatLng(9.202392211274675, 38.78237001138305),
  //         "rating": 3.5,
  //       },
  //       comments: [],
  //       role: "role"),
  //   new User(
  //       uid: "785745",
  //       name: "Minase Alemu",
  //       phone: "+25923343434",
  //       password: "password",
  //       profile: {
  //         "houseNo": "225",
  //         "address": "Addis Ababa, Ethiopia",
  //         "latLng": new LatLng(9.102392211274675, 38.78237001138305),
  //         "rating": 3.5,
  //       },
  //       comments: [],
  //       role: "role")
  // ];

  handleCurrentlySelectedPin(selectedPin) {
    setState(() {
      this.currentlySelectedPin = selectedPin;
      pinPillPosition = 0;
    });
  }

  Future<void> setMapPins() async {
    for (User user in users) {
      final pin = PinInformation(
        userId: user.uid,
        name: user.name,
        phone: user.phone,
        rating: user.profile['rating'],
        houseNo: user.profile['houseNo'],
        location: user.profile['latLng'],
      );
      _markers.add(Marker(
          markerId: MarkerId(user.uid),
          position: user.profile['latLng'],
          onTap: () {
            handleCurrentlySelectedPin(pin);
          },
          icon: markerIcon));
    }
  }

  void setMarkersIcons() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/destination_map_marker.png');
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(
        Provider.of<MyTheme>(context, listen: false).isDarkMode
            ? _mapStyleDark
            : _mapStyleLight);
    _controller.complete(controller);
    setMapPins();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: initialLocation);

    return FutureBuilder(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            users = snapshot.data as List<User>;
            return FutureBuilder(
                future: getCurrentLocation(),
                builder: (BuildContext context, snaphost) {
                  if (snaphost.hasData) {
                    return Stack(children: <Widget>[
                      GoogleMap(
                        padding: EdgeInsets.only(bottom: 100.0, top: 30.0),
                        myLocationEnabled: true,
                        compassEnabled: true,
                        tiltGesturesEnabled: false,
                        markers: _markers,
                        mapType: MapType.normal,
                        initialCameraPosition: initialCameraLocation,
                        onMapCreated: onMapCreated,
                        onTap: (LatLng location) {
                          setState(() {
                            pinPillPosition = -100;
                          });
                        },
                      ),
                      MapPinPill(
                          pinPillPosition: pinPillPosition,
                          currentlySelectedPin: currentlySelectedPin),
                    ]);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
