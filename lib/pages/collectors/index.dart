import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_example/pages/collectors/collector_home_page.dart';
import 'package:flutter_firestore_example/pages/collectors/map.dart';
import 'package:flutter_firestore_example/pages/collectors/profile.dart';
import 'package:flutter_firestore_example/services/user_services.dart';

class CollectorIndexPage extends StatefulWidget {
  CollectorIndexPage({Key? key}) : super(key: key);

  @override
  _CollectorIndexPageState createState() => _CollectorIndexPageState();
}

class _CollectorIndexPageState extends State<CollectorIndexPage> {
  late final UserServices userServices;

  late List<Widget> pages;

  int _currentIndex = 1;
  late Widget map;
  late Widget profile;
  late Widget collectorHome;

  @override
  void initState() {
    super.initState();
    userServices = new UserServices();
    collectorHome = CollectorHomePage(title: "Collector");
    profile = CollectorProfilePage();
    map = MapPage();

    pages = [collectorHome, map, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Theme.of(context).cardTheme.color,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Dashboard'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.pin_drop),
            title: Text('Map'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
