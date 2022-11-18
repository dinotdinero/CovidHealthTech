import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/widgets/customAppBar.dart';
import 'package:flutter_appcovidhealth2/widgets/customT.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassstate createState() => _ChangePassstate();
}

class _ChangePassstate extends State<ChangePass> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _oldPass = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmT = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool checkCurrentPassword = true;
  final currentUser = FirebaseAuth.instance.currentUser();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.lightBlue[700]),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            color: Colors.white,
          ),
        ),
        title: Text(
          "Change Password",
          style: TextStyle(
              fontSize: 40.0,
              color: Colors.lightBlue[700],
              fontFamily: "Signatra"),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  EvaIcons.questionMark,
                  color: Colors.lightBlue[700],
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          content: Container(
                            height: 500,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              semanticContainer: true,
                              child: Image.asset(
                                'images/cp.jpg',
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(10),
                            ),
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 20.0),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                          controller: _oldPass,
                          obscureText: true,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusColor: Theme.of(context).primaryColor,
                            hintText: "Password",
                          ),
                          validator: (value) {
                            return HealthApp.sharedPreferences
                                        .getString(HealthApp.userPassword) ==
                                    value
                                ? null
                                : "please enter your old password";
                          }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                          controller: _newPassword,
                          obscureText: true,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusColor: Theme.of(context).primaryColor,
                            hintText: "New Password",
                          ),
                          validator: (value) {
                            // ignore: unrelated_type_equality_checks
                            return _oldPass.text != value
                                ? null
                                : "Cannot Use Old Password";
                          }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                          controller: _confirmT,
                          obscureText: true,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusColor: Theme.of(context).primaryColor,
                            hintText: "Confirm New Password",
                          ),
                          validator: (value) {
                            // ignore: unrelated_type_equality_checks
                            return _newPassword.text == value
                                ? null
                                : "Password does not match";
                          }),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Colors.lightBlue[700],
                onPressed: () {
                  if (!_formkey.currentState.validate()) {
                    return;
                  }
                  _formkey.currentState.save();
                  _changePassword(_newPassword.text).then((value) {
                    _formkey.currentState.reset();
                  });
                },
                child: Text(
                  "Change Password",
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

  Future<void> _changePassword(String password) async {
    password = _newPassword.text;
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    user.updatePassword(password).then((_) {
      HealthApp.firestore
          .collection(HealthApp.collectionUser)
          .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
          .updateData({
        'password': _newPassword.text,
      }).then((_) {
        Fluttertoast.showToast(msg: "Password changed successfully");
      });
    }).catchError((error) {
      print("Error " + error.toString());
    });
    await HealthApp.sharedPreferences
        .setString(HealthApp.userPassword, _newPassword.text);
    HealthApp.user.reload();
    HealthApp.sharedPreferences.reload();
  }
}
