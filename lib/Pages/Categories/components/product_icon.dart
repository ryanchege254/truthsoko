// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/src/models/category.dart';
import 'package:truthsoko/src/Widget/constants.dart';
import 'package:truthsoko/src/themes/theme.dart';
import 'package:truthsoko/src/themes/light_color.dart';
import 'package:truthsoko/src/Widget/extentions.dart';
import 'package:truthsoko/src/Widget/title_text.dart';

class ProductIcon extends StatelessWidget {
  // final String imagePath;
  // final String text;
  final ValueChanged<Category> onSelected;
  final Category model;
  const ProductIcon({Key? key, required this.model, required this.onSelected})
      : super(key: key);

  @override
  // ignore: duplicate_ignore
  Widget build(BuildContext context) {
    return model.id == null
        ? Container(width: 5)
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Consumer<SelectedCategory>(
              builder: (context, selected, child) {
                return Container(
                  padding: AppTheme.hPadding,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: model.isSelected!
                        ? LightColor.background
                        : Colors.transparent,
                    border: Border.all(
                      color: model.isSelected!
                          ? Global.orange
                          : Colors.transparent,
                      width: model.isSelected! ? 2 : 1,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: model.isSelected!
                            ? const Color(0xfffbf2ef)
                            : Colors.white,
                        blurRadius: 6,
                        spreadRadius: 5,
                        offset: const Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      model.image == null
                          ? Container()
                          : Image.asset(
                              model.image!,
                              fit: BoxFit.cover,
                            ),
                      model.name == null
                          ? Container()
                          : TitleText(
                              text: model.name.toString(),
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            )
                    ],
                  ),
                ).ripple(
                  () {
                    ///onSelected(model);
                    selected.onSelected(onSelected, model);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                );
              },
            ),
          );
  }
}

class SelectedCategory extends ChangeNotifier {
  String? tab = Category().name;
  String? get selected => tab;

  onSelected(ValueChanged<Category> onSelected, Category model) {
    onSelected(model);
    notifyListeners();
  }

  itemSelected(Category model) {
    for (var item in Category.categoryList) {
      item.isSelected = false;
    }
    model.isSelected = true;
    tab = selected;
    notifyListeners();
  }
}
