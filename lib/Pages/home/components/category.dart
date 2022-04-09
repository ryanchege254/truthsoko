import 'package:flutter/material.dart';
import 'package:truthsoko/src/models/category.dart';
import 'package:truthsoko/src/themes/theme.dart';

import '../../../src/Widget/color.dart';
import 'product_icon.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.transparent,
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
