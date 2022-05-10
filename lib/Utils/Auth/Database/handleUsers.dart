import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truthsoko/src/models/User.dart';

class UserHandler {
  final collection = FirebaseFirestore.instance.collection("Users");

  Future addUsers(UserModel user) async {
    await collection.add(user.toJson());
  }

  Future updateUser(UserModel user, String id) async {
    await collection.doc(id).update(user.toJson());
  }
}
