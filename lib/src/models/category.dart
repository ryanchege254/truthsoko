// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum CategoryTab { Vegetables, Legumes, Fruits, Cereals, Herbs }

class Category {
  String? id;
  CategoryTab? tab;
  String? name;
  String? image;
  bool? isSelected;
  Category({
    this.tab,
    this.id,
    this.name,
    this.isSelected,
    this.image,
  });

  //Example of category
  static List<Category> categoryList = [
    // Category(id: 0, image: '', name: ''),
    Category(
        id: "vegetables",
        name: "Vegetables",
        image: 'assets/images/categories/carrot.png',
        isSelected: true,
        tab: CategoryTab.Vegetables),

    Category(
        id: "legumes",
        name: "Legumes",
        image: 'assets/images/categories/finepeas.png',
        isSelected: false,
        tab: CategoryTab.Legumes),
    Category(
        id: "fruits",
        name: "Fruits",
        image: 'assets/images/categories/fruits.png',
        isSelected: false,
        tab: CategoryTab.Fruits),
    Category(
        id: "cereals",
        name: "Cereals",
        image: 'assets/images/categories/wheatseed.png',
        isSelected: false,
        tab: CategoryTab.Cereals),
    Category(
        id: "herbs",
        name: "Herbs",
        image: 'assets/images/categories/rosemary.png',
        isSelected: false,
        tab: CategoryTab.Herbs),
  ];
}

class SelectedCategory extends ChangeNotifier {
  CategoryTab tab = CategoryTab.Vegetables;
  CategoryTab get selected => tab;

  onSelected(ValueChanged<Category> onSelected, Category model) {
    onSelected(model);
    notifyListeners();
  }

  itemSelected(Category model) {
    for (var item in Category.categoryList) {
      item.isSelected = false;
    }
    model.isSelected = true;
    tab = model.tab!;
    notifyListeners();
  }
}
