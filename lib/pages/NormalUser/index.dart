import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_example/pages/NormalUser/Comments.dart';
import 'package:flutter_firestore_example/pages/NormalUser/Hacks.dart';
import 'package:flutter_firestore_example/pages/NormalUser/Tips.dart';
import 'package:flutter_firestore_example/pages/NormalUser/normal_user_home_page.dart';
import 'package:flutter_firestore_example/pages/NormalUser/profile.dart';
import 'package:flutter_firestore_example/services/user_services.dart';

class NormalUserIndexPage extends StatefulWidget {
  NormalUserIndexPage({Key? key}) : super(key: key);

  @override
  _NormalUserIndexPageState createState() => _NormalUserIndexPageState();
}

class _NormalUserIndexPageState extends State<NormalUserIndexPage> {
  late List<Widget> pages;
  int _currentIndex = 0;
  late Widget currentPage;
  late Widget hacks;
  late Widget tips;
  late Widget comments;
  late Widget profile;
  late Widget dashboard;
  late final UserServices userServices;

  @override
  void initState() {
    super.initState();
    userServices = new UserServices();
    hacks = Hacks();
    tips = RecycleTips();
    comments = Comments();
    profile = ProfilePage();
    dashboard = NormalUserHomePage(title: "title");
    pages = [dashboard, hacks, tips, comments, profile];

    currentPage = pages[0];
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
            icon: Icon(Icons.people),
            title: Text('Users'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.info),
            title: Text(
              "Tips",
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text(
              "Comments",
            ),
            activeColor: Colors.pink,
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
