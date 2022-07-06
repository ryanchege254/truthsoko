import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/src/models/User.dart';

import '../Auth/Auth.dart';

class UserHandler {
  final collection = FirebaseFirestore.instance.collection("Users");
// Save user in database
  Future addUsers(UserModel user, String uID) async {
    await collection
        .doc(uID)
        .set(user.toJson())
        .then((value) => print("User saved.........${user.email}"));
    
  }

  Future updateUser(UserModel user, String id) async {
    await collection.doc(id).update(user.toJson());
  }
// fetch user data for update profile page
  getUSerProfile(String user) {
    collection.doc(user).get();
  }
}
