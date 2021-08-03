import 'package:flutter/material.dart';
import 'package:flutter_firestore_example/model/user.dart';
import 'package:flutter_firestore_example/services/user_services.dart';
import 'package:flutter_firestore_example/widgets/dialog.dart';

import 'login_screen.dart';

class SignUpPage extends StatefulWidget {
  // final VoidCallback onSignedIn;
  // const SignUpPage({Key? key, required this.onSignedIn}) : super(key: key);
  static const routeName = "/register";

  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  UserServices _userServices = new UserServices();
  bool _showPassword = false;
  String _name = "";
  String _phone = "";
  String _password = "";
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  int selectedRadio = -1;

  @override
  void initState() {
    super.initState();
    selectedRadio = -1;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        decoration: BoxDecoration(),
        child: Column(children: [
          logo(isKeyboardShowing),
          Align(
            alignment:
                isKeyboardShowing ? Alignment.center : Alignment.bottomCenter,
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    height: height * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildNameTextField(),
                        SizedBox(
                          height: 10,
                        ),
                        _buildPhoneNumberField(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildPasswordTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildChooseUserTypeField(),
                        SizedBox(
                          height: 20.0,
                        ),
                        _submitButton(),
                        _createAccountLabel(),
                      ],
                    ),
                  ),
                )),
          ),
        ]),
      ),
    );
  }

  Widget logo(isKeyboardShowing) {
    return ClipPath(
      clipper: BezierClipper(),
      child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF1f40b7),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xff4064f3),
                    Color(0xff9607c1),
                  ])),
          width: double.infinity,
          height: isKeyboardShowing
              ? MediaQuery.of(context).size.height * 0.25
              : MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: isKeyboardShowing ? 0.0 : 100.0,
                width: 500,
                // child: Image.asset(
                //   'assets/images/logo.png',
                //   fit: BoxFit.cover,
                // ),
              ),
              SizedBox(
                height: isKeyboardShowing ? 0.0 : 30.0,
              ),
              Text(
                'Register',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          )),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/login", (route) => false);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(5),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xff4064f3),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      onChanged: (value) => _phone = value,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: Theme.of(context).textTheme.bodyText1,
        // alignLabelWithHint: true,
        prefixIcon: Icon(Icons.phone),
        // hintText: 'Enter your email',
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xfff3f3f4),
      ),
      cursorColor: Colors.black12,
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      controller: _nameController,
      validator: (value) => value!.length <= 4
          ? "Company Name must be at least 4 character"
          : null,
      onSaved: (value) => _name = value!,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Name',
        focusColor: Color(0xff4064f3),
        labelStyle: Theme.of(context).textTheme.bodyText1,
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xfff3f3f4),
        prefixIcon: Icon(Icons.person),
      ),
      cursorColor: Colors.black12,
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) => value!.length <= 6
          ? "Password must be 6 or more characters in length"
          : null,
      obscureText: !this._showPassword,
      onSaved: (value) => _password = value!,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Password',
        focusColor: Color(0xff4064f3),
        labelStyle: Theme.of(context).textTheme.bodyText1,
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xfff3f3f4),
        prefixIcon: Icon(Icons.security),
        suffixIcon: IconButton(
          icon: this._showPassword
              ? Icon(Icons.remove_red_eye)
              : Icon(Icons.remove_red_eye_sharp),
          onPressed: () {
            setState(() => this._showPassword = !this._showPassword);
          },
        ),
      ),
      cursorColor: Colors.black12,
    );
  }

  Widget _buildChooseUserTypeField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: ListTile(
          title: Text("User"),
          leading: Radio(
            value: 0,
            groupValue: selectedRadio,
            onChanged: (val) {
              setSelectedRadio(val as int);
            },
          ),
        )),
        Expanded(
            child: ListTile(
          title: Text("Collector"),
          leading: Radio(
            value: 1,
            groupValue: selectedRadio,
            onChanged: (val) {
              setSelectedRadio(val as int);
            },
          ),
        )),
      ],
    );
  }

  Widget _submitButton() {
    return InkWell(
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
        child: Text('SignUp',
            // style: TextStyle(fontSize: 20, color: Colors.white),
            style: TextStyle(color: Colors.white, fontSize: 18.0)),
      ),
    );
  }

  void handleSubmit() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      print(_phone + _password);
      form.save();

      print(selectedRadio);

      var user = User(
          uid: 'uid',
          name: _name,
          phone: _phone,
          password: _password,
          comments: [],
          role: selectedRadio == 0 ? "NORMAL_USER" : "COLLECTOR_USER",
          profile: {});

      try {
        await _userServices.addUser(user.toJson());
        setState(() {});
        // final user = await widget.auth.SignIn(_phone, _password);
        DialogBox().information(
            context, 'SignUp Success', 'You have Successfully Registered!');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        setState(() {});
      } catch (err) {
        print('error');
        print(err);
      }
    }
  }
}
