import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firestore_example/model/user.dart';
import 'package:flutter_firestore_example/pages/NormalUser/profile_widget.dart';
import 'package:flutter_firestore_example/utils/auth_provider.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  static const routeName = "/editProfile";

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ImagePicker _picker = new ImagePicker();

  final _formKey = GlobalKey<FormState>();

  late double latitude;
  late double longitude;
  bool locationSelected = false;

  final _nameController = TextEditingController();
  final _houseNumberController = TextEditingController();
  // final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // String _verticalGroupValue = "Bole";

  final Map<String, dynamic> _user = {};

  List<Address> _places = [
    Address(index: 1, name: "Bole"),
    Address(index: 2, name: "Addis Ketema"),
    Address(index: 3, name: "Gulele"),
    Address(index: 4, name: "Arada"),
    Address(index: 5, name: "Bole Lemi"),
  ];

  int _selectedRadio = -1;
  int id = -1;

  setSelectedRadio(int val) {
    setState(() {
      // selectedRadio = val;
    });
  }

  String address = '';

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    User u = Provider.of<UserRepository>(context).authenticatedUser!;
    _user["uid"] = u.uid;
    _user["name"] = u.name;
    // _user["uid"] = u.uid;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.moon_stars),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildProfilePhotoField(),
                SizedBox(
                  height: 20.0,
                ),
                _buildFullNameField(),
                SizedBox(
                  height: 20.0,
                ),
                _buildPhoneFiled(),
                SizedBox(
                  height: 20.0,
                ),
                _buildHouseNumberField(),
                SizedBox(
                  height: 20.0,
                ),
                _buildWorkingDay(),
                SizedBox(
                  height: 20.0,
                ),
                _buildAddressField(context),
                SizedBox(
                  height: 20.0,
                ),
                _buildGetLocation(),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                _buildSubmitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhotoField() {
    // final user = UserPreferences.myUser;
    return Stack(
      children: <Widget>[
        ProfileWidget(
          imagePath:
              'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
          onClicked: () async {},
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (builder) => _buildBottomSheet(),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 28.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile photo',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              )
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {});
    // print(_imageFile.path + ' profile page');
  }

  Widget _buildFullNameField() {
    return TextFormField(
      controller: _nameController,
      validator: (value) => value!.isEmpty ? 'Full Name is required' : null,
      onSaved: (value) {
        setState(() {
          this._user['fullName'] = value;
        });
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        isCollapsed: true,
        labelText: _user["name"],
        labelStyle: TextStyle(color: Colors.black),
        hintText: 'Bekele Petros',
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
    );
  }

  Widget _buildPhoneFiled() {
    return TextFormField(
      controller: _phoneController,
      // validator: (value) => value.isEmpty ? 'Last Name cannot be empty' : null,
      onSaved: (value) {
        setState(() {
          this._user['phone'] = value;
        });
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        isCollapsed: true,
        labelText: "Phone",
        labelStyle: TextStyle(color: Colors.black),
        hintText: '0912345678',
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
    );
  }

  Widget _buildHouseNumberField() {
    return TextFormField(
      controller: _houseNumberController,
      validator: (value) =>
          value!.isEmpty ? 'House Number cannot be empty' : null,
      onSaved: (value) {
        setState(() {
          this._user['houseNo'] = value;
        });
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        isCollapsed: true,
        labelText: "House Number",
        labelStyle: TextStyle(color: Colors.black),
        hintText: '2532',
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
    );
  }

  Widget _buildWorkingDay() {
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
      initialValue: [""],
      title: Text("Available Days"),
      headerColor: Theme.of(context).colorScheme.secondary,
      decoration: BoxDecoration(
        border: Border.all(width: 1.8),
      ),
      selectedChipColor: Theme.of(context).colorScheme.onPrimary,
      selectedTextStyle: TextStyle(color: Colors.white),
      onSaved: (values) {
         setState(() {
          this._user['availableDays'] = values;
        });
      },
      onTap: (values) {
        //_selectedAnimals4 = values;
        // setState(() {
          // this._user['availableDays'] = [values];
        // });
      },
    );
  }

  Widget _buildAddressField(BuildContext context) {
    return ListTile(
      title: Text(
        address == '' ? 'Select Address' : address,
      ),
      onTap: () {
        _showSingleChoiceDialog(context);
      },
    );
  }

  _showSingleChoiceDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          // final _singleNotifier = Provider.of<SingleNotifier>(context);
          return AlertDialog(
            title: Text(
              'Select Address',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: _places
                  .map(
                    (place) => RadioListTile(
                      title: Text("${place.name}"),
                      value: place.index,
                      groupValue: id,
                      onChanged: (val) {
                        // address = place.name;
                        // setSelectedRadio(val as int);
                        setState(() {
                          address = place.name;
                          id = place.index;
                          _selectedRadio = val as int;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
              TextButton(
                onPressed: () {
                  setState(() {
                    this._user['address'] = address;
                  });
                  Navigator.pop(context, 'OK');
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        },
      );

  Widget _buildGetLocation() {
    return ListTile(
      title: Text('Tap here to insert Location'),
      trailing: IconButton(
        color: Theme.of(context).colorScheme.secondary,
        // iconSize: 30,
        icon: Icon(locationSelected ? Icons.check : Icons.pin_drop),
        onPressed: () => getLocation(),
      ),
      onTap: () => getLocation(),
    );
  }

  getLocation() async {
    locationSelected = true;
    await Geolocator.checkPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    final coordinates = new Coordinates(position.latitude, position.longitude);

    latitude = coordinates.latitude;
    longitude = coordinates.longitude;

    setState(() {
      this._user['latitude'] = latitude;
      this._user['longitude'] = longitude;
    });

    _showToast();
  }

  void _showToast() {
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(
      SnackBar(
        content: const Text('Location Selected!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Widget _buildSubmitButton(context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          // shape: StadiumBorder(),
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text('Submit'),
        onPressed: _handleSubmit(context),
      );

  _handleSubmit(BuildContext context) {
    final user = new User(
      uid: this._user["uid"],
      name: this._user['name'],
      phone: this._user['phone'],
      password: this._user['password'],
      comments: this._user['comments'],
      role: this._user['role'],
      profile: {
        'houseNo': this._user['houseNo'],
        'address': this._user['address'],
        'latitude': this._user['latitude'],
        'longitude': this._user['longitude'],
        'availableDays': this._user['availableDays']
      },
    );
    print("clicked");

    context.read<UserRepository>().updateProfile(user);
  }
}

class Address {
  final int index;
  final String name;

  Address({required this.index, required this.name});
}
