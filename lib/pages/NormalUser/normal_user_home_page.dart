// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_firestore_example/model/user.dart';
import 'package:flutter_firestore_example/services/user_services.dart';
import 'package:google_fonts/google_fonts.dart';

class NormalUserHomePage extends StatefulWidget {
  final String title;
  const NormalUserHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _NormalUserHomePageState createState() => _NormalUserHomePageState();
}

class _NormalUserHomePageState extends State<NormalUserHomePage> {
  late final UserServices userServices;

  Future<List<Map<String, Object?>>> fetchUsers() async {
    final data = await userServices.getNormalUsers();
    return data;
  }

  @override
  void initState() {
    super.initState();
    userServices = new UserServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'User Dashboard',
                style: GoogleFonts.varelaRound(
                    fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'It\'s \nbeen',
                    style: GoogleFonts.quando(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '5',
                    style: GoogleFonts.davidLibre(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                  Text(
                    'Days since\nyou trash out',
                    style: GoogleFonts.quando(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _styledCards(context, "Waste", "40 KG", Colors.orange),
                _styledCards(context, "Comments", "100", Colors.yellow)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _styledCards(context, "Recycled", "10 KG", Colors.red),
                _styledCards(context, "Earning", "\$342.37", Colors.green)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _styledCards(
    BuildContext context, String name, String value, Color color) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(5, 30, 5, 0),
      child: Container(
        height: 150,
        width: 150,
        child: Card(
          elevation: 10.0,
          color: color,
          child: Center(
            widthFactor: 10.0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.acme(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      textStyle: TextStyle(),
                    ),
                  ),
                  Text(
                    name,
                    style: GoogleFonts.b612(
                        fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// FutureBuilder(
//           future: fetchUsers(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               final users = snapshot.data as List<Map<String, dynamic>>;
//               print(users[0]['password']);
//               print("password");
//               return Center(child: Text(users[0]['password']));
//             }
//             return Center(child: CircularProgressIndicator());
//           }),
