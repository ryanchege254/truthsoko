import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truthsoko/src/models/Product.dart';

class ProductHandler {
  var firestoreInstance = FirebaseFirestore.instance;

  Future addProduct(ProductModel productModel) async {
    await firestoreInstance.collection("Product").add(productModel.toJson());
  }
}
