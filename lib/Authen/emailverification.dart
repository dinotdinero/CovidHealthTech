import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_appcovidhealth2/Authen/guide.dart';
import 'package:flutter_appcovidhealth2/Dialog/alertDial.dart';
import 'package:flutter_appcovidhealth2/Home/homemenu.dart';
import 'package:flutter_appcovidhealth2/widgets/loadWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Timer timer;
  FirebaseUser firebaseUser;

  @override
  Future<void> initState() async {
    FirebaseUser firebaseUser = await auth.currentUser();
    firebaseUser.sendEmailVerification();
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
        Text("Email Verification Has been sent to your Email,"),
        Text("Please Verify Immedietly."),
        Text("Please check email in spam folder of your email."),
        SizedBox(
          height: 20,
        ),
        Text("Did not Receive Email Verification?"),
        RichText(
            text: TextSpan(
          text: 'Resent Email Verification',
          style: TextStyle(fontSize: 15, color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              resentEmail();
            },
        )),
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
      Route route = MaterialPageRoute(builder: (_) => GuideScreen());
      Navigator.pushReplacement(context, route);
    }
  }

  Future<void> resentEmail() async {
    FirebaseUser firebaseUser = await auth.currentUser();
    firebaseUser.sendEmailVerification().then((v) {
      Fluttertoast.showToast(msg: "Email Verification has been resent");
    });
  }
}
