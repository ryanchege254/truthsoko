import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  UserModel({this.uid, this.username, this.email, this.phone, this.country});
  String? uid;
  String? username;
  String? email;
  String? phone;
  String? country;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json["uid"],
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      country: json["country"]);

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "phone": phone,
        "country": country
      };
  UserModel.fromSnapshot(
      DocumentSnapshot<dynamic> snapshot, BuildContext context)
      : uid = snapshot.id.toString(),
        username = snapshot.data()!['username'],
        email = snapshot.data()!['email'],
        phone = snapshot.data()['phone'],
        country = snapshot.data()['country'];
}
