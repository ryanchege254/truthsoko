import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/src/Widget/constants.dart';
import 'package:truthsoko/src/models/category.dart';
import 'product_icon.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SelectedCategory(),
      child: Consumer<SelectedCategory>(
          builder: (context, SelectedCategory _selected, child) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: Global.fullWidth(context),
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: Category.categoryList
                .map(
                  (category) => ProductIcon(
                    model: category,
                    onSelected: (category) {
                      _selected.itemSelected(category);
                      print(category.name);
                      print(category.tab);
                    },
                  ),
                )
                .toList(),
          ),
        );
      }),
    );
  }
}
