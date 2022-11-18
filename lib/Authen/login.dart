import 'dart:developer';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

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

final GoogleSignIn gSignIn = GoogleSignIn();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
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

class _LoginState extends State<Login> {
  bool iSignedIn;
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
        bottomSheet: Padding(
          padding: EdgeInsets.only(left: 130),
          child: Text(
            "©️ Copyright 2020, Covidhealthtech",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.lightBlue[700],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 10,
                  ),
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
                      "Login To Your Account",
                      style: TextStyle(
                        color: Colors.lightBlue[700],
                      ),
                    ),
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
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
                                RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
                                        .hasMatch(input)
                                    ? null
                                    : "Check your email",
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Forget password?',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Route route = MaterialPageRoute(
                                    builder: (_) => ForgotPass());
                                Navigator.pushReplacement(context, route);
                              },
                          ),
                        ),
                        Text(
                          "ahahahaha",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    child: Text('Login',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    color: Colors.lightBlue[700],
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
                            MaterialPageRoute(builder: (_) => HomeApp());
                        Navigator.pushReplacement(context, route);
                      });
                      log('Google Sign In');
                    },
                    label: Text('Sign In with Google'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                      text: TextSpan(
                    text: 'Create Account? ',
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Route route =
                            MaterialPageRoute(builder: (_) => Register());
                        Navigator.pushReplacement(context, route);
                      },
                  )),
                ],
              ),
            ),
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
      await HealthApp.sharedPreferences
          .setStringList(HealthApp.userLunchCartList, ["cartLunchList"]);
      await HealthApp.sharedPreferences
          .setStringList(HealthApp.userSnackCartList, ["cartSnackList"]);
      await HealthApp.sharedPreferences
          .setStringList(HealthApp.userFoodCartList, ["cartDinnerList"]);
      List<String> cartLunchList =
          dataSnapshot.data[HealthApp.userFoodCartList].cast<String>();
      List<String> cartSnackList =
          dataSnapshot.data[HealthApp.userFoodCartList].cast<String>();
      List<String> cartDinnerList =
          dataSnapshot.data[HealthApp.userFoodCartList].cast<String>();
    });
  }

  Future shardpass() async {
    await HealthApp.sharedPreferences
        .setString(HealthApp.userPassword, _passwordTextEditingController.text);
  }
}
