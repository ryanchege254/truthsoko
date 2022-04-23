import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../src/Widget/constants.dart';
import '../../../src/Widget/fav_btn.dart';
import '../../../src/Widget/price.dart';
import '../../../src/models/Product.dart';
import '../../deatils/details_screen.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: Container(
          padding: const EdgeInsets.all(Global.defaultPadding),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: demo_products.length,
            itemBuilder: (BuildContext context, int index) {
              Product product = demo_products[index % 3];

              return FavoriteCard(
                percentageComplete: 0,
                press: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      reverseTransitionDuration:
                          const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          FadeTransition(
                        opacity: animation,
                        child: DetailsScreen(
                          product: demo_products[index],
                        ),
                      ),
                    ),
                  );
                },
                product: product,
              );
            },
          )),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final Product product;
  final double percentageComplete;
  final VoidCallback press;
  const FavoriteCard({
    Key? key,
    required this.product,
    required this.percentageComplete,
    required this.press,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 150, left: 15, right: 15, top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 3,
            blurRadius: 8,
          )
        ],
        gradient: LinearGradient(
            colors: [Global.orange, Global.white],
            begin: Alignment.topLeft,
            end: Alignment.center),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: press,
              child: Hero(
                tag: product.image!,
                child: Image.asset(product.image!),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 40, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product.title!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Fruits",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Price(amount: "20.00"),
                        const SizedBox(
                          width: 35,
                        ),
                        Hero(tag: product.image!, child: const FavBtn()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
