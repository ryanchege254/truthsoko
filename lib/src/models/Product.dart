class Product {
  final String? title, image;

  Product({this.title, this.image});
}

class ProductModel {
  int? id;
  String? name;
  String? category;
  String? image;
  String? location;
  double? price;
  double? quantity;
  bool? isSelected;

  bool? isliked;
  ProductModel(
      {this.id,
      this.name,
      this.category,
      this.price,
      this.isliked,
      this.isSelected = false,
      this.image});
}

List<Product> demo_products = [
  Product(title: "Cabbage", image: "assets/images/img_1.png"),
  Product(title: "Broccoli", image: "assets/images/img_2.png"),
  Product(title: "Carrot", image: "assets/images/img_3.png"),
  Product(title: "Pakcoy", image: "assets/images/img_4.png"),
  Product(title: "Cucumber", image: "assets/images/img_1.png"),
  Product(title: "Cucumber", image: "assets/images/img_1.png"),
  Product(title: "Cucumber", image: "assets/images/img_1.png"),
  Product(title: "Cucumber", image: "assets/images/img_1.png"),
];
