import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:truthsoko/src/models/User.dart';

class UserHandler  {
  final collection = FirebaseFirestore.instance.collection("Users");

  Future addUsers(UserModel user) async {
    await collection
        .add(user.toJson())
        .then((value) => print("User Saved ${user.email}"));
  }

  Future updateUser(UserModel user, String id) async {
    await collection.doc(id).update(user.toJson());
  }
}
