import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/src/models/Product.dart';

import '../Auth/Auth.dart';

class ProductHandler extends ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;

  Future saveProduct(String firebaseUser, ProductModel productModel) async {
      final savedProduct = firestoreInstance
        .collection("Users")
        .doc(firebaseUser)
        .collection("SavedItems")
        .doc(productModel.documentId).snapshots();
        await savedProduct.isEmpty.then((value) => value?firestoreInstance
        .collection("Users")
        .doc(firebaseUser)
        .collection("SavedItems")
        .add(productModel.toJson()) : (){}) ;
        
   
    notifyListeners();
  }

  Future unsaveProduct(ProductModel productModel, String firebaseUser) async {
    String docId = firestoreInstance
        .collection("Users")
        .doc(firebaseUser)
        .collection("SavedItems")
        .doc()
        .id;

    await firestoreInstance
        .collection("Users")
        .doc(firebaseUser.toString())
        .collection("SavedItems")
        .doc(docId)
        .delete();
  }

  fetchSavedItems(User user) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .collection("SavedItems")
        .snapshots();
  }

  fetchRelatedProducts(String category) {
    firestoreInstance
        .collection("Products")
        .where("category", isEqualTo: category)
        .snapshots();
  }

  onPressed() {
    firestoreInstance.collection("Users").get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        firestoreInstance
            .collection("Users")
            .doc(result.id)
            .collection("SavedItems")
            .get();
      }
    });
  }
}
