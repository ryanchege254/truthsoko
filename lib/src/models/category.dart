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
        name: "Sneakers",
        image: 'assets/images/shoe_thumb_2.png',
        isSelected: true),
    Category(
        id: 2,
        name: "Jacket",
        image: 'assets/images/jacket.png',
        isSelected: false),
    Category(
        id: 3,
        name: "Watch",
        image: 'assets/images/watch.png',
        isSelected: false),
    Category(
        id: 4,
        name: "Watch",
        image: 'assets/images/watch.png',
        isSelected: false),
  ];
}
