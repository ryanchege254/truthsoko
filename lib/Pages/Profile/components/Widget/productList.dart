import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../src/Widget/constants.dart';
import '../../../../src/models/Product.dart';
import '../../../Details/details_screen.dart';
import '../../../home/components/product_card.dart';

Widget productlist(final user, AsyncSnapshot<QuerySnapshot> snapshot) {
  return GridView.builder(
    scrollDirection: Axis.vertical,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      mainAxisSpacing: Global.defaultPadding,
      crossAxisSpacing: Global.defaultPadding,
    ),
    padding: const EdgeInsets.only(right: 32, top: 128),
    itemCount: snapshot.data?.docs.length ?? 0,
    itemBuilder: (context, index) {
      final ProductModel product =
          ProductModel.fromSnapshot(snapshot.data!.docs[index]);
      return ProductCard(
          //index:index,
          product: product,
          percentageComplete: 0,
          press: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                reverseTransitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FadeTransition(
                  opacity: animation,
                  child: DetailsScreen(
                    product: product,
                    user: user,
                  ),
                ),
              ),
            );
          });
    },
  );
}
