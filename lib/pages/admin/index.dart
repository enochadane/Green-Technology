import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_example/pages/admin/admin_home_page.dart';
import 'package:flutter_firestore_example/pages/admin/companies.dart';
import 'package:flutter_firestore_example/services/user_services.dart';

class AdminIndexPage extends StatefulWidget {
  AdminIndexPage({Key? key}) : super(key: key);

  @override
  _AdminIndexPageState createState() => _AdminIndexPageState();
}
class _AdminIndexPageState extends State<AdminIndexPage> {
  late final UserServices userServices;

  late List<Widget> pages;

  int _currentIndex = 0;
  late Widget companyList;
  late Widget adminHome;

  @override
  void initState() {
    super.initState();
    userServices = new UserServices();
    companyList = CompanyPage(title: "Company");
    adminHome = AdminHomePage(title: "Admin");

    pages = [adminHome, companyList, adminHome];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
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
            title: Text('Companies'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Profile'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
