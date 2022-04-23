import 'package:truthsoko/src/Widget/fav_btn.dart';
import 'package:truthsoko/src/Widget/price.dart';
import 'package:truthsoko/src/models/Product.dart';
import 'package:flutter/material.dart';

import 'package:truthsoko/src/Widget/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.index,
    required this.percentageComplete,
    required this.press,
  }) : super(key: key);

  final Product product;
  final double percentageComplete;
  final VoidCallback press;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Global.defaultPadding),
      decoration: const BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.all(
          Radius.circular(Global.defaultPadding * 1.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: press,
            child: Hero(
              tag: index,
              child: Image.asset(product.image!),
            ),
          ),
          Text(
            product.title!,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            "Fruits",
            style: Theme.of(context).textTheme.caption,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Price(amount: "20.00"),
              Hero(tag:index, child: const FavBtn()),
            ],
          )
        ],
      ),
    );
  }
}
