import 'package:flutter/material.dart';
import 'package:truthsoko/src/models/category.dart';

class SelectedCategory extends ChangeNotifier {
  onSelected(ValueChanged<Category> onSelected, Category model) {
    onSelected(model);
    notifyListeners();
  }

  itemSelected(Category model) {
    for (var item in Category.categoryList) {
      item.isSelected = false;
    }
    model.isSelected = true;
    notifyListeners();
  }
}
