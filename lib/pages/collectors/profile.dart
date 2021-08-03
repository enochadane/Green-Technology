import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_example/pages/login_screen.dart';
import 'package:flutter_firestore_example/utils/auth_provider.dart';
import 'package:flutter_firestore_example/utils/my_theme.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CollectorProfilePage extends StatefulWidget {
  static const routeName = "/collectorProfile";

  const CollectorProfilePage({Key? key}) : super(key: key);

  @override
  _CollectorProfilePageState createState() => _CollectorProfilePageState();
}

class _CollectorProfilePageState extends State<CollectorProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Map<String, dynamic> _collector = {
    "orgName": "something",
    "address": "6029b3c1a688f767edf6d0e3",
    "availability": ["Monday", "Wednesday"],
  };

  @override
  void initState() {
    super.initState();
  }

  void onSelect(DateTime picked) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text('Profile', textAlign: TextAlign.center),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            buildOrginazationNameTextField(),
            SizedBox(
              height: 30.0,
            ),
            buildWorkingDay(),
            SizedBox(
              height: 30.0,
            ),
            buildDomainChoice(),
            SizedBox(
              height: 50.0,
            ),
            _submitButton(context)
          ]),
        ),
      ),
    ));
  }

  Widget buildOrginazationNameTextField() {
    return Container(
        child: TextFormField(
      cursorHeight: 20.0,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Organization Name';
        }
        return null;
      },
      onChanged: (text) {},
      initialValue: '',
      onSaved: (value) {
        // setState(() {
        // this._collector["orgName"] = value;
        // });
      },
      decoration: InputDecoration(
        isCollapsed: true,
        labelText: _collector["orgName"],
        hintText: 'Organization Name',
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    ));
  }

  Widget buildWorkingDay() {
    List<String> workingDays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday"
    ];
    final _items =
        workingDays.map((day) => MultiSelectItem<String>(day, day)).toList();
    return MultiSelectChipField(
      items: _items,
      scroll: true,
      height: 100,
      initialValue: _collector['availability'],
      title: Text("Working Days"),
      headerColor: Colors.blue.withOpacity(0.2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 1.8),
      ),
      selectedChipColor: Colors.blue.shade300,
      selectedTextStyle: TextStyle(color: Colors.white),
      onTap: (values) {
        //_selectedAnimals4 = values;
      },
    );
  }

  Widget buildDomainChoice() {
    List<String> _places = [
      "Bole",
      "Addis Ketema",
      "Gulele",
      "Arada",
      "Bole Lemi",
      "Bole",
      "Addis Ketema",
      "Gulele",
      "Arada",
      "Bole Lemi",
      "Bole",
      "Addis Ketema",
      "Gulele",
      "Arada",
      "Bole Lemi",
    ];
    final _items =
        _places.map((place) => MultiSelectItem<String>(place, place)).toList();
    return MultiSelectDialogField(
      items: _items,
      chipDisplay: MultiSelectChipDisplay(),
      height: MediaQuery.of(context).size.height * 0.5,
      searchable: true,
      title: Text("Working Places"),
      selectedColor: Colors.blue,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.01),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
      ),
      buttonIcon: Icon(
        Icons.place,
        color: Colors.blue,
      ),
      buttonText: Text(
        "Working Places",
        style: TextStyle(color: Colors.blue[800], fontSize: 20, height: 2.0),
      ),
      onConfirm: (results) {
        //_selectedAnimals = results;
      },
    );
  }

  Widget buildSubmitButton() {
    return MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {
          final form = _formKey.currentState;
          if (form!.validate()) {
            form.save();
          }
        },
        textColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Text(isLoading ? "Update" : "Loading",
              style: TextStyle(fontSize: 18.0)),
        ));
  }

  void handleSubmit() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
    }
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      focusColor: Colors.blue,
      hoverColor: Colors.blue,
      onTap: () => handleSubmit(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff4064f3),
                  Color(0xff9607c1),
                ])),
        child: Text(!isLoading ? "Update" : "Loading",
            style: TextStyle(color: Colors.white, fontSize: 18.0)),
      ),
    );
  }
}
