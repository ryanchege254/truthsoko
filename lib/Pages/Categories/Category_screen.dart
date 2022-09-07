import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Pages/Categories/components/category.dart';
import 'package:flutter/material.dart';
import 'package:truthsoko/src/Widget/productList.dart';
import 'package:truthsoko/src/Widget/Warning_text.dart';
import 'package:truthsoko/src/Widget/title_text.dart';
import '../../src/Widget/constants.dart';
import '../../src/Widget/header.dart';
import '../../src/models/category.dart';


class CategoryScreen extends StatelessWidget {
  final User user;
  const CategoryScreen({Key? key, required this.user}) : super(key: key);
  String selectedCategory(SelectedCategory selected) {
    if (selected.selected == CategoryTab.Vegetables) {
      return "Vegetable";
    }
    if (selected.selected == CategoryTab.Cereals) {
      return "Cereals";
    }
    if (selected.selected == CategoryTab.Fruits) {
      return "Fruits";
    }
    if (selected.selected == CategoryTab.Herbs) {
      return "Herbs";
    }
    if (selected.selected == CategoryTab.Legumes) {
      return "Legumes";
    }
    return "Fruits";
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SelectedCategory(),
      child: Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeHeader(
                user: user,
              ),
              /*  SearchWidget(
                searchController: searchController,
                user: user,
              ), */
              const SizedBox(
                height: 8,
              ),
              const Padding(
                  padding: EdgeInsets.only(left: Global.defaultPadding),
                  child: TitleText(
                    text: "Categories",
                  )),
              const Categories(),
              // const SizedBox(height: 8),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Global.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(Global.defaultPadding),
                  child: Consumer<SelectedCategory>(
                    builder: ((context, SelectedCategory selected, child) {
                      switch (selected.selected) {
                        case CategoryTab.Vegetables:
                          return ProductList(
                              user: user, category: selectedCategory(selected));
                        case CategoryTab.Fruits:
                          return ProductList(
                              user: user, category: selectedCategory(selected));
                        case CategoryTab.Legumes:
                          return ProductList(
                              user: user, category: selectedCategory(selected));
                        case CategoryTab.Herbs:
                          return ProductList(
                              user: user, category: selectedCategory(selected));
                        case CategoryTab.Cereals:
                          return ProductList(
                              user: user, category: selectedCategory(selected));

                        default:
                      }
                      return const Padding(
                        padding: EdgeInsets.all(35.0),
                        child: LoadingIndicator(
                            indicatorType: Indicator.circleStrokeSpin),
                      );
                    }),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductList extends StatelessWidget {
  final User user;
  String category;
  ProductList({Key? key, required this.user, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Products")
            .where("category", isEqualTo: category)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(40),
              child: LoadingIndicator(
                colors: [Global.green, Global.orange],
                indicatorType: Indicator.ballSpinFadeLoader,
              ),
            ));
          } else if (snapshot.hasError) {
            return Center(
                child: WarningText(
                    text: "Something went wrong: ${snapshot.error}"));
          }

          return productlist(user, snapshot);
        });
  }
}
