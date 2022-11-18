import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_appcovidhealth2/widgets/customAppBar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassstate createState() => _ForgotPassstate();
}

class _ForgotPassstate extends State<ForgotPass> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailCont = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool checkCurrentPassword = true;
  final currentUser = FirebaseAuth.instance.currentUser();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 50.0),
              Form(
                key: _formkey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: emailCont,
                    obscureText: false,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusColor: Theme.of(context).primaryColor,
                      hintText: "Enter Email",
                    ),
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val.toString())
                          ? null
                          : "Invalid Email address";
                    },
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.lightBlue[700],
                onPressed: () {
                  if (!_formkey.currentState.validate()) {
                    return;
                  }
                  _formkey.currentState.save();
                  resetPassword(emailCont.text).then((value) {
                    _formkey.currentState.reset();
                  });
                  Route route = MaterialPageRoute(builder: (_) => Login());
                  Navigator.pushReplacement(context, route);
                },
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
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
    );
  }

  Future resetPassword(String email) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: emailCont.text).then((_) {
        Fluttertoast.showToast(
            msg:
                "Reset Password has been sent to your email. Please check if email is in Spam");
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
