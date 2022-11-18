import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter_appcovidhealth2/Authen/emailverification.dart';
import 'package:flutter_appcovidhealth2/Authen/register.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Dialog/ErroDial.dart';
import 'package:flutter_appcovidhealth2/Dialog/alertDial.dart';
import 'package:flutter_appcovidhealth2/Home/homemenu.dart';
import 'package:flutter_appcovidhealth2/widgets/customT.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'forogtpassword.dart';
import 'googlesign.dart';
import 'loginemailVerification.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

Future<FirebaseUser> _loginWithGoogle() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  AuthResult signInResult = await auth.signInWithCredential(credential);
  final FirebaseUser user = signInResult.user;
  return user;
}

class _MyappState extends State<Myapp> {
  @override
  bool iSignedIn;
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.45,
                child: Image.asset(
                  'assets/yoga.png',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          suffixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        controller: _passwordTextEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: Icon(Icons.visibility_off),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Forget password?',
                        style: TextStyle(fontSize: 12.0),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Route route =
                                MaterialPageRoute(builder: (_) => ForgotPass());
                            Navigator.pushReplacement(context, route);
                          },
                      ),
                    ),
                    RaisedButton(
                      child: Text('Login'),
                      color: Color(0xffEE7B23),
                      onPressed: () {
                        _emailTextEditingController.text.isNotEmpty &&
                                _passwordTextEditingController.text.isNotEmpty
                            ? loginUser()
                            : showDialog(
                                context: context,
                                builder: (c) {
                                  return ErrorAlertDialog(
                                    message: "Please write email and password",
                                  );
                                });
                        shardpass();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text.rich(
                  TextSpan(text: 'Don\'t have an account', children: [
                    TextSpan(
                      text: 'Signup',
                      style: TextStyle(color: Color(0xffEE7B23)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Authenticating, Please wait......",
          );
        });
    FirebaseUser firebaseUser;
    await _auth
        .signInWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((error) {
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
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => LoginVerify());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(FirebaseUser fUser) async {
    Firestore.instance
        .collection("users")
        .document(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await HealthApp.sharedPreferences
          .setString(HealthApp.userUID, dataSnapshot.data[HealthApp.userUID]);
      await HealthApp.sharedPreferences.setString(
          HealthApp.userEmail, dataSnapshot.data[HealthApp.userEmail]);
      await HealthApp.sharedPreferences
          .setString(HealthApp.userName, dataSnapshot.data[HealthApp.userName]);
      await HealthApp.sharedPreferences.setString(
          HealthApp.userAvatarUrl, dataSnapshot.data[HealthApp.userAvatarUrl]);
      List<String> cartList =
          dataSnapshot.data[HealthApp.userCartList].cast<String>();
      await HealthApp.sharedPreferences
          .setStringList(HealthApp.userCartList, ["cartList"]);
      List<String> cartFoodList =
          dataSnapshot.data[HealthApp.userFoodCartList].cast<String>();
      await HealthApp.sharedPreferences
          .setStringList(HealthApp.userFoodCartList, ["cartFoodList"]);
    });
  }

  Future shardpass() async {
    await HealthApp.sharedPreferences
        .setString(HealthApp.userPassword, _passwordTextEditingController.text);
  }
}
