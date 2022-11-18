import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_appcovidhealth2/Authen/register.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Home/Exercise.dart';
import 'package:flutter_appcovidhealth2/Home/food.dart';
import 'package:flutter_appcovidhealth2/Home/foodhome.dart';
import 'package:flutter_appcovidhealth2/Home/homemenu.dart';
import 'package:flutter_appcovidhealth2/Home/profilepage.dart';
import 'package:flutter_appcovidhealth2/Home/ttodo.dart';
import 'package:flutter_appcovidhealth2/Monitoring/Monitoring.dart';
import 'package:flutter_appcovidhealth2/Authen/googlesign.dart';
import 'package:flutter_appcovidhealth2/Home/ChangePassword.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
            decoration: new BoxDecoration(
              color: Colors.lightBlue[700],
            ),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  elevation: 8.0,
                  child: Container(
                    height: 160.0,
                    width: 160.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        HealthApp.sharedPreferences
                            .getString(HealthApp.userAvatarUrl),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  HealthApp.sharedPreferences.getString(HealthApp.userName),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 33.0,
                      fontFamily: "Signatra"),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              top: 1,
            ),
            child: Column(
              children: [
                ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.lightBlue[700],
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(color: Colors.lightBlue[700]),
                    ),
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (_) => HomeApp());
                      Navigator.pushReplacement(context, route);
                    }),
                Divider(
                  height: 10.0,
                  color: Colors.lightBlue[700],
                  thickness: 4.0,
                ),
                ListTile(
                    leading: Icon(
                      Icons.note,
                      color: Colors.lightBlue[700],
                    ),
                    title: Text(
                      "Diary",
                      style: TextStyle(color: Colors.lightBlue[700]),
                    ),
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (_) => TodoApp());
                      Navigator.pushReplacement(context, route);
                    }),
                Divider(
                  height: 10.0,
                  color: Colors.lightBlue[700],
                  thickness: 4.0,
                ),
                ListTile(
                    leading: Icon(
                      Icons.fitness_center,
                      color: Colors.lightBlue[700],
                    ),
                    title: Text(
                      "Exercise",
                      style: TextStyle(color: Colors.lightBlue[700]),
                    ),
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (_) => Exercise());
                      Navigator.pushReplacement(context, route);
                    }),
                Divider(
                  height: 10.0,
                  color: Colors.lightBlue[700],
                  thickness: 4.0,
                ),
                ListTile(
                    leading: Icon(
                      Icons.food_bank,
                      color: Colors.lightBlue[700],
                    ),
                    title: Text(
                      "Dietary Menu",
                      style: TextStyle(color: Colors.lightBlue[700]),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (_) => Foodhome());
                      Navigator.pushReplacement(context, route);
                    }),
                Divider(
                  height: 10.0,
                  color: Colors.lightBlue[700],
                  thickness: 4.0,
                ),
                ListTile(
                    leading: Icon(
                      Icons.note,
                      color: Colors.lightBlue[700],
                    ),
                    title: Text(
                      "Monitoring",
                      style: TextStyle(color: Colors.lightBlue[700]),
                    ),
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (_) => Monitoring());
                      Navigator.pushReplacement(context, route);
                    }),
                Divider(
                  height: 10.0,
                  color: Colors.lightBlue[700],
                  thickness: 4.0,
                ),
                ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.lightBlue[700],
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(color: Colors.lightBlue[700]),
                    ),
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (_) => ProfilePage());
                      Navigator.pushReplacement(context, route);
                    }),
                Divider(
                  height: 10.0,
                  color: Colors.lightBlue[700],
                  thickness: 4.0,
                ),
                ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: Colors.lightBlue[700],
                    ),
                    title: Text(
                      "Change Password",
                      style: TextStyle(color: Colors.lightBlue[700]),
                    ),
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (_) => ChangePass());
                      Navigator.pushReplacement(context, route);
                    }),
                Divider(
                  height: 10.0,
                  color: Colors.lightBlue[700],
                  thickness: 4.0,
                ),
                ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.lightBlue[700],
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(color: Colors.lightBlue[700]),
                    ),
                    onTap: () {
                      signOutWithGoogle().then((c) {
                        Route route =
                            MaterialPageRoute(builder: (_) => Register());
                        Navigator.pushReplacement(context, route);
                      });
                    }),
                Divider(
                  height: 10.0,
                  color: Colors.lightBlue[700],
                  thickness: 4.0,
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<Null> signOutWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    GoogleSignInAccount _currentUser;
    await HealthApp.auth.signOut();

    await googleSignIn.signOut();
  }
}
