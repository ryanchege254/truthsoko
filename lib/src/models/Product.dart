/*class Product {
  final String? title, image;

  Product({this.title, this.image});
}*/

// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.documentId,
    this.title,
    this.category,
    this.image,
    this.location,
    this.price,
    this.quantity,
    this.isliked,
  });
  String? documentId;
  String? title;
  String? category;
  String? image;
  String? location;
  String? price;
  String? quantity;
  bool? isliked;
  Future<Widget> getImage(BuildContext context, String imageName) async {
    Widget? image;
    await FirebaseImageStorage.loadimage(context, imageName).then((value) {
      image = CachedNetworkImage(
        imageUrl: value.toString(),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ); /* Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      ); */
    });
    return image!;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        title: json["title"],
        category: json["category"],
        image: json["image"],
        location: json["location"],
        price: json["price"],
        quantity: json["quantity"],
        isliked: json["isliked"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "category": category,
        "image": image,
        "location": location,
        "price": price,
        "quantity": quantity,
        "isliked": isliked,
      };
  ProductModel.fromSnapshot(DocumentSnapshot<dynamic> snapshot)
      : documentId = snapshot.id,
        title = snapshot.data()!['title'],
        category = snapshot.data()!['category'],
        image = snapshot.data()['image'],
        location = snapshot.data()['location'],
        price = snapshot.data()['price'],
        quantity = snapshot.data()['quantity'],
        isliked = snapshot.data()['isliked'];
}

List<ProductModel> demo_productsModel = [
  ProductModel(
    image: 'assets/images/img_1.png',
  ),
  ProductModel(
    image: 'assets/images/img_2.png',
  ),
  ProductModel(
    image: 'assets/images/img_3.png',
  ),
  ProductModel(
    image: 'assets/images/img_4.png',
  ),
  ProductModel(
    image: 'assets/images/img_5.png',
  ),
];

class FirebaseImageStorage extends ChangeNotifier {
  FirebaseImageStorage();
  static Future<dynamic> loadimage(BuildContext context, String image) async {
    return await FirebaseStorage.instance
        .ref("Product")
        .child(image)
        .getDownloadURL();
  }
}
