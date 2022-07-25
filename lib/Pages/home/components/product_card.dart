import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:truthsoko/src/Widget/fav_btn.dart';
import 'package:truthsoko/Pages/Details/components/price.dart';
import 'package:truthsoko/src/models/Product.dart';
import 'package:flutter/material.dart';

import 'package:truthsoko/src/Widget/constants.dart';

class ProductCard extends StatelessWidget {
  final User user;
  const ProductCard({
    Key? key,
    required this.product,
    required this.percentageComplete,
    required this.press,
    required this.user,
  }) : super(key: key);

  final ProductModel product;
  final double percentageComplete;
  final VoidCallback press;

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
            child: FutureBuilder(
                future: ProductModel().getImage(context, product.image!),
                builder: ((context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      child: snapshot.data,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return const LoadingIndicator(
                      indicatorType: Indicator.circleStrokeSpin,
                    );
                  }
                  return Container();
                })),
          ),
          Text(
            product.title ?? "",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              product.location ?? "",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Text(
            product.category ?? "",
            style: Theme.of(context).textTheme.caption,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Price(
                amount: product.price ?? "",
              ),
              Hero(
                  tag: product.documentId ?? "",
                  child: FavBtn(
                    product: product,
                    user: user,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
