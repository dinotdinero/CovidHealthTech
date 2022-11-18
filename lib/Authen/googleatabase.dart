import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Database {
  final colReference = Firestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  Future addUserInformation(String username, String uid,
      {String userimage =
          "https://cdn0.iconfinder.com/data/icons/user-pictures/100/unknown2-512.png"}) async {
    return await colReference.document(uid).setData({
      'name': username,
      'url': userimage,
    });
  }

  Future getUserData(String uid) async {
    var user = await colReference.document(uid).get();
    return user;
  }
}
