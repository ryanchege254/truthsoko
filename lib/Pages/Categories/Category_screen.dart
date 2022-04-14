import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Pages/Categories/components/category.dart';
import 'package:truthsoko/Pages/home/components/Search_text_field.dart';
import 'package:truthsoko/Utils/Auth/screen_changeProvider.dart';
import 'package:truthsoko/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:truthsoko/Pages/home/components/Drawer.dart';
import '../../src/Widget/color.dart';
import '../../src/models/Product.dart';
import '../deatils/details_screen.dart';
import '../home/components/product_card.dart';
import 'components/header.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(children: [
        const HomeHeader(),
        const SizedBox(
          height: 10,
        ),
        const Categories(),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(Global.defaultPadding),
          child: Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: Global.defaultPadding,
                crossAxisSpacing: Global.defaultPadding,
              ),
              padding: const EdgeInsets.only(right: 32, top: 128),
              itemCount: demo_products.length,
              itemBuilder: (context, index) {
                Product product = demo_products[index % 3];
                return ProductCard(
                    product: product,
                    percentageComplete: 1,
                    press: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          reverseTransitionDuration:
                              const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  FadeTransition(
                            opacity: animation,
                            child: DetailsScreen(
                              product: demo_products[index],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ),
      ]),
    );
  }
}
