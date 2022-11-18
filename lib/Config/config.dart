import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HealthApp {
  String appName = 'CovidHealthTech';

  static SharedPreferences sharedPreferences;
  static FirebaseUser user;
  static FirebaseAuth auth;
  static Firestore firestore;
  static FirebaseDatabase firebaseDatabase;

  static String collectionUser = "users";

  static String userCartList = 'userCart';
  static String userFoodCartList = 'userFoodCart';
  static String subCollectionMonitoring = 'userMonitoring';
  static String subCollectionDiary = 'userDiary';
  static String userLunchCartList = 'userLunchCart';
  static String userSnackCartList = 'userSnackCart';
  static String userDinnerCartList = 'userDinnerCart';

  static String userName = 'name';
  static String userEmail = 'email';
  static String userPhotoUrl = 'photoUrl';
  static String userUID = 'uid';
  static String userAvatarUrl = 'url';
  static String userPassword = 'pass';
  static String userMonitoring = "monitoringId";
  static String userDiary = "diaryId";
  static String userWeight = 'weight';
  static String userHeight = 'height';
  static final String isSuccess = 'isSuccess';
}
