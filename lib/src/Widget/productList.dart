import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:truthsoko/src/Widget/Warning_text.dart';
import 'constants.dart';
import '../models/Product.dart';
import '../../Pages/Details/details_screen.dart';
import '../../Pages/home/components/product_card.dart';

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
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {
      if (snapshot.data!.docs.isEmpty) {
        return const Center(
            child: WarningText(text: "No Product has been Added yet"));
      } else if (snapshot.data != null) {
        if (kDebugMode) {
          print("........................................not null");
        }
      }
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
        },
        user: user,
      );
    },
  );
}
