import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel {
  String title;
  String recipe;
  String ImageURL;
  String procedure;
  String status;
  String classification;
  int num;

  FoodModel({
    this.title,
    this.recipe,
    this.ImageURL,
    this.procedure,
    this.classification,
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    recipe = json['recipe'];
    ImageURL = json['ImageURL'];
    classification = json['classification'];
    procedure = json['procedure'];
    status = json['status'];
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['recipe'] = this.recipe;
    data['ImageURL'] = this.ImageURL;
    data['procedure'] = this.procedure;
    data['classification'] = this.classification;
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
