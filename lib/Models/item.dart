import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String title;
  String repitition;
  String typeofExercise;
  String ImageURL;
  String instriction;
  String status;
  int num;

  ItemModel({
    this.title,
    this.repitition,
    this.ImageURL,
    this.instriction,
    this.typeofExercise,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    repitition = json['repitition'];
    typeofExercise = json['typeofExercise'];

    ImageURL = json['ImageURL'];
    instriction = json['instriction'];
    status = json['status'];
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['repitition'] = this.repitition;
    data['ImageURL'] = this.ImageURL;
    data['instriction'] = this.instriction;
    data['typeofExercise'] = this.typeofExercise;
    data['num'] = this.num;
    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
