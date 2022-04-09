class Category {
  int id;
  String name;
  String image;
  bool isSelected;
  Category(
      {required this.id,
      required this.name,
      required this.isSelected,
      required this.image});

  //Example of category
  static List<Category> categoryList = [
    // Category(id: 0, image: '', name: ''),
    Category(
        id: 1,
        name: "Vegatables",
        image: 'assets/images/img_1.png',
        isSelected: true),
    Category(
        id: 2,
        name: "Legumes",
        image: 'assets/images/img_2.png',
        isSelected: false),
    Category(
        id: 3,
        name: "Fruits",
        image: 'assets/images/img_3.png',
        isSelected: false),
    Category(
        id: 4,
        name: "Cereals",
        image: 'assets/images/img_4.png',
        isSelected: false),
  ];
}
