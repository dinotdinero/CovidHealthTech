import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appcovidhealth2/Authen/guide.dart';
import 'package:flutter_appcovidhealth2/Authen/loginemailVerification.dart';
import 'package:flutter_appcovidhealth2/Authen/register.dart';
import 'package:flutter_appcovidhealth2/Monitoring/Monitoring.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/counter/TotalDinner.dart';
import 'package:flutter_appcovidhealth2/counter/TotalLunch.dart';
import 'package:flutter_appcovidhealth2/counter/TotalSnack.dart';
import 'package:flutter_appcovidhealth2/counter/dinnercounter.dart';
import 'package:flutter_appcovidhealth2/counter/todochanger.dart';
import 'package:flutter_appcovidhealth2/widgets/loadWidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter/material.dart';
import 'Authen/emailverification.dart';

import 'Authen/googlesign.dart';
import 'Home/homemenu.dart';
import 'counter/ItemQuantity.dart';
import 'counter/changeMonitoring.dart';
import 'counter/foodQuantity.dart';
import 'counter/fooditemcounter.dart';
import 'counter/itemcounter.dart';

import 'counter/lunchcounter.dart';
import 'counter/snackconter.dart';
import 'counter/totalMoney.dart';
import 'counter/TotalFood.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HealthApp.auth = FirebaseAuth.instance;
  HealthApp.sharedPreferences = await SharedPreferences.getInstance();
  HealthApp.firestore = Firestore.instance;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => ItemQuantity()),
        ChangeNotifierProvider(create: (c) => FoodQuantity()),
        ChangeNotifierProvider(create: (c) => FoodCounter()),
        ChangeNotifierProvider(create: (c) => MonitoringChanger()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
        ChangeNotifierProvider(create: (c) => TotalFood()),
        ChangeNotifierProvider(create: (_) => GoogleSigninProvider()),
        ChangeNotifierProvider(create: (c) => TodoChanger()),
        ChangeNotifierProvider(create: (c) => SnackCounter()),
        ChangeNotifierProvider(create: (c) => TotalSnack()),
        ChangeNotifierProvider(create: (c) => LunchCounter()),
        ChangeNotifierProvider(create: (c) => TotalLunch()),
        ChangeNotifierProvider(create: (c) => TotalDinner()),
        ChangeNotifierProvider(create: (c) => DinnerCounter()),
      ],
      child: MaterialApp(
          title: '',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
          home: SplashScreen()),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

    displaySplash();
  }

  displaySplash() {
    Timer(Duration(seconds: 5), () async {
      if (await HealthApp.auth.currentUser() != null) {
        Route route = MaterialPageRoute(builder: (_) => LoginVerify());
        Navigator.pushReplacement(context, route);
      } else {
        Route route = MaterialPageRoute(builder: (_) => Register());
        Navigator.pushReplacement(context, route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.

        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo1.png"),
            SizedBox(
              height: 20.0,
            ),
            Text(""),
            Container(
              child: Center(
                child: circularProgress(),
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
