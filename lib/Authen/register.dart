import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_appcovidhealth2/Authen/googlesign.dart';
import 'package:flutter_appcovidhealth2/Authen/guide.dart';
import 'package:flutter_appcovidhealth2/Authen/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Dialog/ErroDial.dart';
import 'package:flutter_appcovidhealth2/Dialog/alertDial.dart';
import 'package:flutter_appcovidhealth2/Home/homemenu.dart';
import 'emailverification.dart';

import 'package:flutter_appcovidhealth2/widgets/customT.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmpTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final String imageURL =
      "https://firebasestorage.googleapis.com/v0/b/conid-97729.appspot.com/o/pic_1171831236_1.png?alt=media&token=9d204818-445a-417c-a66f-c6c0041f8416";
  final String height = "0";
  final String weight = "0";

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.lightBlue[700]),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
          ),
          title: Text(
            "CovidHealthTech",
            style: TextStyle(
                fontSize: 55.0,
                color: Colors.lightBlue[700],
                fontFamily: "Signatra"),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "images/logo1.png",
                      height: 190,
                      width: 190,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "CovidHealthTech",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.lightBlue[700],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Register an a Account",
                      style: TextStyle(
                        color: Colors.lightBlue[700],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        CustomTextField(
                          contr: _nameTextEditingController,
                          image: Icons.person,
                          hintT: "Name",
                          iso: false,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.all(10.0),
                          child: TextFormField(
                            validator: (input) =>
                                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(input)
                                    ? null
                                    : "Invalid Email",
                            controller: _emailTextEditingController,
                            obscureText: false,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.lightBlue[700],
                              ),
                              focusColor: Theme.of(context).primaryColor,
                              hintText: "Email",
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.all(10.0),
                          child: TextFormField(
                            validator: (input) => RegExp(
                                        r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
                                    .hasMatch(input)
                                ? null
                                : "Must have Atleast one uppercase,\none lowercase,\none number,\none special character,\nMinimum eight in length",
                            controller: _passwordTextEditingController,
                            obscureText: true,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.lightBlue[700],
                              ),
                              focusColor: Theme.of(context).primaryColor,
                              hintText: "Password",
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.all(10.0),
                          child: TextFormField(
                              controller: _confirmpTextEditingController,
                              obscureText: true,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.lightBlue[700],
                                ),
                                focusColor: Theme.of(context).primaryColor,
                                hintText: "Confirm Password",
                              ),
                              validator: (value) {
                                return _passwordTextEditingController.text ==
                                        _confirmpTextEditingController.text
                                    ? null
                                    : "Password does not match";
                              }),
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (!_formkey.currentState.validate()) {
                        return;
                      }

                      uploadToStore().then((value) {
                        _formkey.currentState.reset();
                      });
                    },
                    color: Colors.lightBlue[700],
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Or",
                    style: TextStyle(
                        color: Colors.lightBlue[700],
                        fontSize: 13,
                        fontFamily: "Signatra"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: HexColor('#386FEC'),
                        onPrimary: Colors.white,
                        minimumSize: Size(50, 50)),
                    icon: FaIcon(FontAwesomeIcons.google, color: Colors.orange),
                    onPressed: () {
                      final provider = Provider.of<GoogleSigninProvider>(
                          context,
                          listen: false);
                      provider.googleLogin().then((c) {
                        Route route =
                            MaterialPageRoute(builder: (_) => GuideScreen());
                        Navigator.pushReplacement(context, route);
                      });
                      log('Google Sign up');
                    },
                    label: Text('Sign up with Google'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                      text: TextSpan(
                    text: 'Alreeady Have an Account? ',
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Route route =
                            MaterialPageRoute(builder: (_) => Login());
                        Navigator.pushReplacement(context, route);
                      },
                  )),
                  SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadAndSave() async {
    _passwordTextEditingController.text == _confirmpTextEditingController.text
        ? _emailTextEditingController.text.isNotEmpty &&
                _passwordTextEditingController.text.isNotEmpty &&
                _confirmpTextEditingController.text.isNotEmpty &&
                _nameTextEditingController.text.isNotEmpty
            ? uploadToStore()
            : displayDialog("Please fill up the required form")
        : displayDialog("Password do not match");
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  uploadToStore() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Authenticating, please wait",
          );
        });

    _registerUser();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    FirebaseUser firebaseUser;

    await _auth
        .createUserWithEmailAndPassword(
          email: _emailTextEditingController.text.trim(),
          password: _passwordTextEditingController.text.trim(),
        )
        .then((auth) {
          firebaseUser = auth.user;
        })
        .then((FirebaseUser user) {})
        .catchError((error) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (c) {
                return ErrorAlertDialog(
                  message: error.message.toString(),
                );
              });
        });
    if (firebaseUser != null) {
      saveUserInfoToFireStore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => VerifyScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUserInfoToFireStore(FirebaseUser fUser) async {
    Firestore.instance.collection("users").document(fUser.uid).setData({
      "uid": fUser.uid,
      "name": _nameTextEditingController.text.trim(),
      "email": fUser.email,
      "url": imageURL,
      "password": _passwordTextEditingController.text,
      "weight": int.parse(weight),
      "height": int.parse(height),
      HealthApp.userFoodCartList: ["garbageValue"],
      HealthApp.userCartList: ["garbageValue"],
      HealthApp.userLunchCartList: ["garbageValue"],
      HealthApp.userSnackCartList: ["garbageValue"],
      HealthApp.userDinnerCartList: ["garbageValue"],
    });
    await HealthApp.sharedPreferences.setString(HealthApp.userUID, fUser.uid);
    await HealthApp.sharedPreferences
        .setString(HealthApp.userEmail, fUser.email);
    await HealthApp.sharedPreferences
        .setString(HealthApp.userName, _nameTextEditingController.text);
    await HealthApp.sharedPreferences.setString(HealthApp.userHeight, height);
    await HealthApp.sharedPreferences.setString(HealthApp.userWeight, weight);
    await HealthApp.sharedPreferences
        .setStringList(HealthApp.userCartList, ["garbageValue"]);
    await HealthApp.sharedPreferences
        .setStringList(HealthApp.userFoodCartList, ["garbageValue"]);
    await HealthApp.sharedPreferences
        .setStringList(HealthApp.userLunchCartList, ["garbageValue"]);
    await HealthApp.sharedPreferences
        .setStringList(HealthApp.userSnackCartList, ["garbageValue"]);
    await HealthApp.sharedPreferences
        .setStringList(HealthApp.userDinnerCartList, ["garbageValue"]);

    await HealthApp.sharedPreferences
        .setString(HealthApp.userPassword, _passwordTextEditingController.text);
    await HealthApp.sharedPreferences
        .setString(HealthApp.userAvatarUrl, imageURL);
  }
}

extension EmailValidator on String {
  bool isValidEmail(String input) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}

extension PassValidator on String {
  bool isPassEmail() {
    return RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
        .hasMatch(this);
  }
}
