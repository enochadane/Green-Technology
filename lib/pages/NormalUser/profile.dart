import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_example/model/user.dart';
import 'package:flutter_firestore_example/pages/NormalUser/profile_widget.dart';
import 'package:flutter_firestore_example/pages/login_screen.dart';
import 'package:flutter_firestore_example/services/user_services.dart';
import 'package:flutter_firestore_example/utils/auth_provider.dart';
import 'package:flutter_firestore_example/utils/my_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/userProfile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserServices _userServices = new UserServices();

  @override
  Widget build(BuildContext context) {
    User user1 =
        Provider.of<UserRepository>(context, listen: false).authenticatedUser!;
    // User user1 = context.read<UserRepository>().authenticatedUser;
    final user = new User(
        uid: user1.uid,
        name: user1.name,
        phone: user1.phone,
        password: user1.password,
        // profile: {},
        profile: {
          "houseNo": "",
          "address": "",
          "latLng": null,
          "rating": 0,
        },
        comments: [],
        role: "role");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer<MyTheme>(builder: (context, notifier, child) {
            return IconButton(
                icon: Icon(
                  !notifier.isDarkMode
                      ? CupertinoIcons.moon_stars
                      : CupertinoIcons.sun_max_fill,
                  color: Colors.deepOrange,
                  size: 30.0,
                ),
                onPressed: () {
                  notifier.toggleTheme();
                });
          }),
          PopupMenuButton(
            child: Icon(
              Icons.more_vert,
              color: Colors.deepOrange,
              size: 30.0,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("settings"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Logout"),
                value: 2,
              ),
            ],
            onSelected: (val) {
              switch (val) {
                case 2:
                  {
                    Provider.of<UserRepository>(context, listen: false)
                        .signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginPage.routeName, (route) => false);
                  }
              }
            },
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath:
                'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(
              child: Text(
            user.profile['rating'].toString(),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          )),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.orange[300],
              ),
              Icon(
                Icons.star,
                color: Colors.orange[300],
              ),
              Icon(
                Icons.star,
                color: Colors.orange[300],
              ),
              Icon(
                Icons.star,
                color: Colors.orange[300],
              ),
              Icon(
                Icons.star,
                color: Colors.orange[300],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      user.phone,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Icon(Icons.map_outlined),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      user.profile['address'],
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Icon(Icons.home),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      user.profile['houseNo'],
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lock_clock),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Availability",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            'Monday',
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.black),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.green, spreadRadius: 3),
                            ],
                          ),
                          height: 25,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            'Thursday',
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.black),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.green, spreadRadius: 3),
                            ],
                          ),
                          height: 25,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            'Sunday',
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.black),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.green, spreadRadius: 3),
                            ],
                          ),
                          height: 25,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/editProfile");
        },
        child: Icon(Icons.edit, color: Colors.white,),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            "user",
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
}
