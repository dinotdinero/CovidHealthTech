import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appcovidhealth2/Config/config.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'googleatabase.dart';

class GoogleSigninProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final String imageurl =
      "https://firebasestorage.googleapis.com/v0/b/conid-97729.appspot.com/o/pic_1171831236_1.png?alt=media&token=9d204818-445a-417c-a66f-c6c0041f8416";
  Database db = Database();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount _user;

  GoogleSignInAccount get user => _user;

  Future<FirebaseUser> googleLogin() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    updateUserData(user);
  }

  Future<void> signOutWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    await HealthApp.auth.signOut();
    // Sign out with google
    await googleSignIn.signOut();
  }

  Future<bool> checkIfDocExists(String uid) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = await Firestore.instance.collection('users');

      var doc = await collectionRef.document(uid).get();
      return doc.exists;
    } catch (e) {
      return false;
      throw e;
    }
  }
}

Future updateUserData(FirebaseUser user) async {
  final String height = "0";
  final String weight = "0";
  final String imageurl =
      "https://firebasestorage.googleapis.com/v0/b/conid-97729.appspot.com/o/pic_1171831236_1.png?alt=media&token=9d204818-445a-417c-a66f-c6c0041f8416";
  DocumentReference ref =
      Firestore.instance.collection("users").document(user.uid);
  ref.setData({
    'uid': user.uid,
    'email': user.email,
    'url': imageurl,
    'name': user.displayName,
    'lastSeen': DateTime.now(),
    "weight": int.parse(weight),
    "height": int.parse(height),
    HealthApp.userFoodCartList: ["garbageValue"],
    HealthApp.userCartList: ["garbageValue"],
    HealthApp.userLunchCartList: ["garbageValue"],
    HealthApp.userSnackCartList: ["garbageValue"],
    HealthApp.userDinnerCartList: ["garbageValue"],
  }, merge: true);

  await HealthApp.sharedPreferences.setString(HealthApp.userUID, user.uid);
  await HealthApp.sharedPreferences.setString(HealthApp.userHeight, height);
  await HealthApp.sharedPreferences.setString(HealthApp.userWeight, weight);
  await HealthApp.sharedPreferences.setString(HealthApp.userEmail, user.email);
  await HealthApp.sharedPreferences
      .setString(HealthApp.userAvatarUrl, imageurl);
  await HealthApp.sharedPreferences
      .setString(HealthApp.userName, user.displayName);
  await HealthApp.sharedPreferences
      .setStringList(HealthApp.userCartList, ["garbageValue"]);
  await HealthApp.sharedPreferences
      .setStringList(HealthApp.userFoodCartList, ["garbageValue"]);
  await HealthApp.sharedPreferences
      .setStringList(HealthApp.userLunchCartList, ["garbageValue"]);
  await HealthApp.sharedPreferences
      .setStringList(HealthApp.userSnackCartList, ["garbageValue"]);
  await HealthApp.sharedPreferences
      .setStringList(HealthApp.userDinnerCartList, ["garbageValue"]);
}
