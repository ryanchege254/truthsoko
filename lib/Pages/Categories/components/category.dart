import 'package:flutter/material.dart';
import 'package:truthsoko/src/models/category.dart';
import 'package:truthsoko/src/themes/theme.dart';

import '../../../src/Widget/color.dart';
import '../../home/components/product_icon.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        width: AppTheme.fullWidth(context),
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
      ),
    );
  }
}
