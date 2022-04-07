import 'package:flutter/material.dart';
import 'package:truthsoko/src/models/category.dart';
import 'package:truthsoko/src/themes/theme.dart';

import '../../../src/Widget/color.dart';
import 'product_icon.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryWidget();
}

class _CategoryWidget extends State<CategoryWidget> {
  Widget _categoryWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: Category.categoryList
            .map(
              (category) => ProductIcon(
                model: category,
                onSelected: (model) {
                  setState(() {
                    for (var item in Category.categoryList) {
                      item.isSelected = false;
                    }
                    model.isSelected = true;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _categoryWidget();
  }
}

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);
  /* Widget _categoryWidget() {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: Category.categoryList
            .map(
              (category) => ProductIcon(
                model: category,
                onSelected: (model) {
                  for (var item in Category.categoryList) {
                    item.isSelected = false;
                  }
                  model.isSelected = true;
                },
              ),
            )
            .toList(),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(top: 30),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: Category.categoryList
            .map(
              (category) => ProductIcon(
                model: category,
                onSelected: (model) {
                  for (var item in Category.categoryList) {
                    item.isSelected = false;
                  }
                  model.isSelected = true;
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
