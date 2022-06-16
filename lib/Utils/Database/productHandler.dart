import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truthsoko/src/models/Product.dart';

class ProductHandler extends ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  Future<bool> saveProduct(ProductModel productModel, firebaseUser) async {
    await firestoreInstance
        .collection("Users")
        .doc(firebaseUser.toString())
        .collection("Saved Items")
        .add(productModel.toJson());
    notifyListeners();
    return true;
  }

  Future unsaveProduct(ProductModel productModel, firebaseUser) async {
    String docId = firestoreInstance
        .collection("Users")
        .doc(firebaseUser.toString())
        .collection("Saved Items")
        .doc()
        .id;
    await firestoreInstance
        .collection("Users")
        .doc(firebaseUser.toString())
        .collection("Saved Items")
        .doc(docId)
        .delete();
  }

  fetchSavedItems(String id) {
    firestoreInstance
        .collection("Users")
        .doc(id)
        .collection("Saved Items")
        .snapshots();
  }

  fetchRecentItems(String id) {
    firestoreInstance
        .collection("Users")
        .doc(id)
        .collection("Saved Items")
        .snapshots();
  }

  fetchRelatedProducts(String category) {
    firestoreInstance
        .collection("Products")
        .where("category", isEqualTo: "Vegetable")
        .snapshots();
  }
}
