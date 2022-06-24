import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/src/models/Product.dart';

import '../Auth/Auth.dart';

class ProductHandler extends ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;

  Future saveProduct(BuildContext context, ProductModel productModel) async {
    String firebaseUser = Provider.of<UserRepository>(context ,listen: false).getCurrentUID();

    await firestoreInstance
        .collection("Users")
        .doc(firebaseUser)
        .collection("Saved Items")
        .add(productModel.toJson());
    notifyListeners();
  }

  Future unsaveProduct(ProductModel productModel, BuildContext context) async {
        String firebaseUser = Provider.of<UserRepository>(context, listen: false).getCurrentUID();

    String docId = firestoreInstance
        .collection("Users")
        .doc(firebaseUser)
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
        .where("category", isEqualTo: category)
        .snapshots();
  }
}
