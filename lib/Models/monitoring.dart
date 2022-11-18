import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';

class MonitoringModel {
  int day;
  String bloodpressure;
  String temperature;
  String oxygenlevel;
  String heartbeat;
  String monitoringId;
  Timestamp publishedDate;
  String cough;
  String tired;
  String smell;
  String sore;
  String breath;
  String speech;
  String chest;

  MonitoringModel({
    this.day,
    this.bloodpressure,
    this.temperature,
    this.oxygenlevel,
    this.publishedDate,
    this.heartbeat,
    this.monitoringId,
    this.chest,
    this.cough,
    this.tired,
    this.breath,
    this.smell,
    this.sore,
    this.speech,
  });

  MonitoringModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    bloodpressure = json['bloodpressure'];
    temperature = json['temperature'];
    oxygenlevel = json['oxygenlevel'];
    heartbeat = json['heartbeat'];
    publishedDate = json['publishedDate'];
    monitoringId = json["monitoringId"];
    chest = json["chest"];
    cough = json["cough"];
    tired = json["tired"];
    breath = json["breath"];
    smell = json["smell"];
    sore = json["sore"];
    speech = json["speech"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['bloodpressure'] = this.bloodpressure;
    data['temperature'] = this.temperature;
    data['oxygenlevel'] = this.oxygenlevel;
    data['heartbeat'] = this.heartbeat;
    data['publishedDate'] = this.publishedDate;
    data['monitoringId'] = this.monitoringId;
    data["chest"] = this.chest;
    data["breath"] = this.breath;
    data["cough"] = this.cough;
    data["tired"] = this.tired;
    data["smell"] = this.smell;
    data["sore"] = this.sore;
    data["speech"] = this.speech;

    return data;
  }

  static Future<void> deleteItem({
    String monitoringId,
  }) async {
    DocumentReference documentReference = HealthApp.firestore
        .collection(HealthApp.collectionUser)
        .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
        .collection(HealthApp.subCollectionMonitoring)
        .document(monitoringId);

    await documentReference
        .delete()
        .whenComplete(() => print("Successfully Deleted"));
  }
}

class publishedDate {
  String date;

  publishedDate({this.date});

  publishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
