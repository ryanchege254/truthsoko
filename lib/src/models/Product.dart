/*class Product {
  final String? title, image;

  Product({this.title, this.image});
}*/

// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.title,
    this.category,
    this.image,
    this.location,
    this.price,
    this.quantity,
    this.isliked,
  });

  String? title;
  String? category;
  String? image;
  String? location;
  double? price;
  String? quantity;
  String? isliked;

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
}

/*List<Product> demo_products = [
  Product(title: "Cabbage", image: "assets/images/img_1.png"),
  Product(title: "Broccoli", image: "assets/images/img_2.png"),
  Product(title: "Carrot", image: "assets/images/img_3.png"),
  Product(title: "Pakcoy", image: "assets/images/img_4.png"),
  Product(title: "Cucumber", image: "assets/images/img_1.png"),
  Product(title: "Cucumber", image: "assets/images/img_1.png"),
  Product(title: "Cucumber", image: "assets/images/img_1.png"),
  Product(title: "Cucumber", image: "assets/images/img_1.png"),
];*/
List<ProductModel> demo_productsModel = [
  ProductModel(
      title: "Cabbage",
      image: "assets/images/img_1.png",
      price: 20.0,
      category: "Vegatable",
      location: "Nairobi"),
  ProductModel(
      title: "Broccoli",
      image: "assets/images/img_2.png",
      price: 20.0,
      location: "Nairobi",
      category: "Fruits"),
  ProductModel(
    title: "Carrot",
    image: "assets/images/img_3.png",
    price: 20.0,
    category: "Vegatable",
    location: "Nairobi",
  ),
  ProductModel(
    title: "Pakcoy",
    image: "assets/images/img_4.png",
    price: 20.0,
    category: "Fruits",
    location: "Nairobi",
  ),
  ProductModel(
    title: "Cucumber",
    image: "assets/images/img_1.png",
    price: 20.0,
    category: "Vegatable",
    location: "Nairobi",
  ),
  ProductModel(
    title: "Cucumber2",
    image: "assets/images/img_1.png",
    price: 20.0,
    category: "Fruits",
    location: "Nairobi",
  ),
  ProductModel(
    title: "Cucumber3",
    image: "assets/images/img_1.png",
    price: 20.0,
    category: "Vegatable",
    location: "Nairobi",
  ),
  ProductModel(
    title: "Cucumber4",
    image: "assets/images/img_1.png",
    price: 20.0,
    category: "Fruits",
    location: "Nairobi",
  ),
];
