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

class ViewMonitoring extends StatefulWidget {
  final MonitoringModel monitoringModel;
  ViewMonitoring({this.monitoringModel});
  @override
  _ViewMonitoringState createState() => _ViewMonitoringState();
}

class _ViewMonitoringState extends State<ViewMonitoring> {
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
  void initState() {
    cDay.text = (widget.monitoringModel.day).toString();
    cTemp.text = widget.monitoringModel.temperature;
    cHeartBeat.text = widget.monitoringModel.heartbeat;
    cough.text = widget.monitoringModel.cough;
    tired.text = widget.monitoringModel.tired;
    smell.text = widget.monitoringModel.smell;
    sore.text = widget.monitoringModel.sore;
    breath.text = widget.monitoringModel.breath;
    speech.text = widget.monitoringModel.speech;
    chest.text = widget.monitoringModel.chest;
    super.initState();
  }

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
                        hint: "example:64",
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
                        hint: "",
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
                          "difficulty breathing or shortness of breath?",
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
          enabled: false,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        validator: (val) => val.isEmpty ? "Field can not be empty." : null,
      ),
    );
  }
}
