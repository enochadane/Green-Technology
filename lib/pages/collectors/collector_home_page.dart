// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_firestore_example/model/user.dart';
import 'package:flutter_firestore_example/services/user_services.dart';
import 'package:google_fonts/google_fonts.dart';

class CollectorHomePage extends StatefulWidget {
  final String title;
  const CollectorHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _CollectorHomePageState createState() => _CollectorHomePageState();
}

class _CollectorHomePageState extends State<CollectorHomePage> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Collector Dashboard',
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
                    '18,364',
                    style: GoogleFonts.davidLibre(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                  Text(
                    'App \nDownloads',
                    style: GoogleFonts.quando(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _styledCards(context, "Users", "1297", Colors.orange),
                _styledCards(context, "Members", "1137", Colors.yellow)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _styledCards(context, "Waste/Ton", "129317", Colors.red),
                _styledCards(context, "Earning", "34237", Colors.green)
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
      padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
      child: Container(
        height: 120,
        width: 120,
        child: Card(
          color: color,
          child: Center(
            widthFactor: 10.0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
              child: ListTile(
                title: Text(
                  value,
                  style: GoogleFonts.acme(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  name,
                  style: GoogleFonts.b612(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
