import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:flutter_appcovidhealth2/Home/Exercise.dart';
import 'package:flutter_appcovidhealth2/Home/homemenu.dart';
import 'package:flutter_appcovidhealth2/Widgets/customAppBar.dart';
import 'package:flutter_appcovidhealth2/Models/monitoring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appcovidhealth2/widgets/myDrawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'Monitoring.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class AddMonitoring extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final cDay = TextEditingController();
  final cBloodpre = TextEditingController();
  final cTemp = TextEditingController();
  final cOxyLevel = TextEditingController();
  final cHeartBeat = TextEditingController();
  final cough = TextEditingController();
  final tired = TextEditingController();
  final smell = TextEditingController();
  final sore = TextEditingController();
  final breath = TextEditingController();
  final speech = TextEditingController();
  final chest = TextEditingController();
  final publishedDate = DateTime.now();
  String monitoringId = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    HealthApp.userMonitoring = cDay.text;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.lightBlue[700]),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
          ),
          title: Text(
            "Monitoring",
            style: TextStyle(
                fontSize: 55.0,
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
                                  'images/addmonitor.png',
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final dbRef = FirebaseDatabase.instance.reference();
            if (formKey.currentState.validate()) {
              var monitoringModel = MonitoringModel(
                day: int.parse(cDay.text),
                temperature: cTemp.text,
                heartbeat: cHeartBeat.text,
                monitoringId: monitoringId,
                chest: chest.text,
                cough: cough.text,
                smell: smell.text,
                sore: sore.text,
                speech: speech.text,
                breath: breath.text,
                tired: tired.text,
              );
              final model = monitoringModel.toJson();
              HealthApp.firestore
                  .collection(HealthApp.collectionUser)
                  .document(
                      HealthApp.sharedPreferences.getString(HealthApp.userUID))
                  .collection(HealthApp.subCollectionMonitoring)
                  .document(monitoringId)
                  .setData({
                "day": int.parse(cDay.text),
                "temperature": cTemp.text,
                "monitoringId": monitoringId,
                "heartbeat": cHeartBeat.text,
                "publishedDate": DateTime.now(),
                "chest": chest.text,
                "cough": cough.text,
                "smell": smell.text,
                "sore": sore.text,
                "speech": speech.text,
                "breath": breath.text,
                "tired": tired.text,
              }).then((value) {
                int ctemp = int.parse(cTemp.text);
                int cheart = int.parse(cHeartBeat.text);
                if (ctemp > 37 &&
                    cheart < 90 &&
                    cheart > 80 &&
                    sore.text == "No" &&
                    cough.text == "No" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "No" &&
                    tired.text == "No" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please Contact your doctor as you have a high temperature",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp > 37 &&
                    cheart > 90 &&
                    cheart < 80 &&
                    sore.text == "No" &&
                    cough.text == "No" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "No" &&
                    tired.text == "No" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please Contact your doctor as you have a high temperature and a Abnormal heartbeat rate",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp < 37 &&
                    cheart > 90 &&
                    cheart < 80 &&
                    sore.text == "No" &&
                    cough.text == "No" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "No" &&
                    tired.text == "No" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please Contact your doctor as you have a Abnormal heartbeat rate",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp > 37 &&
                    cheart > 90 &&
                    cheart < 80 &&
                    sore.text == "Yes" &&
                    cough.text == "No" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "Yes" &&
                    tired.text == "No" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please Contact your doctor as you have a Abnormal heartbeat rate, \n a High Temperature, and Both common and Serious Symptoms.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp < 37 &&
                    cheart <= 90 &&
                    cheart >= 80 &&
                    sore.text == "Yes" &&
                    cough.text == "No" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "No" &&
                    tired.text == "No" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please Eat a lot of food so that you can recover fast",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp < 37 &&
                    cheart <= 90 &&
                    cheart >= 80 &&
                    sore.text == "No" &&
                    cough.text == "Yes" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "No" &&
                    tired.text == "No" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please Eat a lot of food so that you can recover fast",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp < 37 &&
                    cheart <= 90 &&
                    cheart >= 80 &&
                    sore.text == "No" &&
                    cough.text == "No" &&
                    smell.text == "Yes" &&
                    speech.text == "No" &&
                    breath.text == "No" &&
                    tired.text == "No" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please Eat a lot of food so that you can recover fast",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp < 37 &&
                    cheart <= 90 &&
                    cheart >= 80 &&
                    sore.text == "No" &&
                    cough.text == "No" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "No" &&
                    tired.text == "Yes" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please Eat a lot of food so that you can recover fast",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp > 37 &&
                    cheart <= 90 &&
                    cheart >= 80 &&
                    sore.text == "Yes" &&
                    cough.text == "No" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "No" &&
                    tired.text == "No" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please Contact your doctor as having a high body temperature and having a Common symptom is ussually a bad sign",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp > 37 &&
                    cheart <= 90 &&
                    cheart >= 80 &&
                    sore.text == "No" &&
                    cough.text == "No" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "Yes" &&
                    tired.text == "No" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please Contact your doctor as having a high body temperature and Have a Serious Symptom that is showing",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp < 37 &&
                    cheart <= 90 &&
                    cheart >= 80 &&
                    sore.text == "No" &&
                    cough.text == "No" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "Yes" &&
                    tired.text == "No" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please Contact your doctor as you may have serious symptom that is showing",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp > 37 &&
                    cheart <= 90 &&
                    cheart >= 80 &&
                    sore.text == "No" &&
                    cough.text == "No" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "Yes" &&
                    tired.text == "Yes" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Hello, you are clearly showing signs of serious symptoms and a high body temperature. Please Contact your doctor immediately for necessary actions to take ",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else if (ctemp > 37 &&
                    cheart <= 90 &&
                    cheart >= 80 &&
                    sore.text == "No" &&
                    cough.text == "Yes" &&
                    smell.text == "No" &&
                    speech.text == "No" &&
                    breath.text == "Yes" &&
                    tired.text == "No" &&
                    chest.text == "No") {
                  Alert(
                    context: context,
                    title: "Alert",
                    desc:
                        "Please contact your doctor immediately, as you are having a high Body temperature and having common symptom and a serious symptom is a bad sign",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (_) => Monitoring());
                          Navigator.pushReplacement(context, route);
                        },
                        width: 120,
                      )
                    ],
                  ).show();
                } else {}
              });
            }
          },
          label: Text(
            "Done",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightBlue[700],
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Add New Monotoring",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "Day",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      MyTextField(
                        hint: "Day",
                        controller: cDay,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "Temperature (°C)",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      MyTextField(
                        hint: "Answer in Celsius",
                        controller: cTemp,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "HeartBeat Per Minute",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      MyTextField(
                        hint:
                            "Answer after 1 minute of taking the Heartbeat rate",
                        controller: cHeartBeat,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Common Symptoms: Please Answer in Yes Or No",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Cough?",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      MyTextField(
                        hint: "Answer in Yes or No",
                        controller: cough,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "tiredness?",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      MyTextField(
                        hint: "Answer in Yes or No",
                        controller: tired,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Loss of Smell Or Taste?",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      MyTextField(
                        hint: "Answer in Yes or No",
                        controller: smell,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("Sore Throat"),
                      ),
                      MyTextField(
                        hint: "Answer in Yes or No",
                        controller: sore,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Serious Symptoms:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Difficulty breathing or shortness of breath?",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      MyTextField(
                        hint: "Answer in Yes or No",
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        controller: breath,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "loss of speech or mobility, or confusion?",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      MyTextField(
                        hint: "Answer in Yes or No",
                        controller: speech,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Chest Pain?",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      MyTextField(
                        hint: "Answer in Yes or No?",
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        controller: chest,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  MyTextField({
    Key key,
    this.hint,
    this.controller,
    decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (val) => val.isEmpty ? "Field can not be empty." : null,
      ),
    );
  }
}
