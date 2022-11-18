import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_appcovidhealth2/Dialog/alertDial.dart';
import 'package:flutter_appcovidhealth2/Home/homemenu.dart';
import 'package:flutter_appcovidhealth2/widgets/loadWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginVerify extends StatefulWidget {
  @override
  _LoginVerifyState createState() => _LoginVerifyState();
}

class _LoginVerifyState extends State<LoginVerify> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Timer timer;
  FirebaseUser firebaseUser;

  @override
  Future<void> initState() async {
    FirebaseUser firebaseUser = await auth.currentUser();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel;
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: circularProgress(),
        ),
        Text("Authenticating, Please wait..."),
      ]),
    ));
  }

  Future<void> checkEmailVerified() async {
    FirebaseUser firebaseUser = await auth.currentUser();
    await firebaseUser.reload();
    if (firebaseUser.isEmailVerified) {
      firebaseUser = await auth.currentUser();
      await firebaseUser.reload();
      timer.cancel();
      Route route = MaterialPageRoute(builder: (_) => HomeApp());
      Navigator.pushReplacement(context, route);
    }
  }
}
