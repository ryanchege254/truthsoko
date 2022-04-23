// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return model.id == null
        ? Container(width: 5)
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Container(
              padding: AppTheme.hPadding,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: model.isSelected
                    ? LightColor.background
                    : Colors.transparent,
                border: Border.all(
                  color: model.isSelected ? Global.orange : Colors.transparent,
                  width: model.isSelected ? 2 : 1,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: model.isSelected
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
                  model.image != null
                      ? Image.asset(model.image)
                      : const SizedBox(),
                  model.name == null
                      ? Container()
                      : TitleText(
                          text: model.name,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        )
                ],
              ),
            ).ripple(
              () {
                onSelected(model);
              },
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          );
  }
}
