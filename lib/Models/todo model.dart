import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';

class DiaryModel {
  String diaryId;
  String story;
  String title;
  Timestamp publishedDate;
  String url;

  DiaryModel({
    this.diaryId,
    this.story,
    this.title,
    this.publishedDate,
    this.url,
  });

  DiaryModel.fromJson(Map<String, dynamic> json) {
    diaryId = json['diaryId'];
    story = json['story'];
    title = json['title'];
    publishedDate = json['publishedDate'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diaryId'] = this.diaryId;
    data['story'] = this.story;
    data['title'] = this.title;
    data['publishedDate'] = this.publishedDate;
    data['url'] = this.url;
    return data;
  }

  factory DiaryModel.fromJason(DocumentSnapshot snapshot) {
    return DiaryModel(
      diaryId: snapshot["diaryId"],
      story: snapshot["story"],
      title: snapshot['title'],
      publishedDate: snapshot['publishedDate'],
      url: snapshot['url'],
    );
  }

  static Future<void> deleteItem({
    String diaryId,
  }) async {
    DocumentReference documentReference = HealthApp.firestore
        .collection(HealthApp.collectionUser)
        .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
        .collection(HealthApp.subCollectionDiary)
        .document(diaryId);

    await documentReference
        .delete()
        .whenComplete(() => print("Successfully Deleted"));
  }

  static Future<void> updateItem(
      String diaryId, String title, String story, String url) async {
    DocumentReference documentReference = HealthApp.firestore
        .collection(HealthApp.collectionUser)
        .document(HealthApp.sharedPreferences.getString(HealthApp.userUID))
        .collection(HealthApp.subCollectionDiary)
        .document(diaryId);

    await documentReference.updateData({
      'title': title,
      'story': story,
      "url": url,
    }).whenComplete(() => print("Successfully Deleted"));
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
