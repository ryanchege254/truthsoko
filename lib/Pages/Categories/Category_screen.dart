import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Pages/Categories/components/category.dart';
import 'package:flutter/material.dart';
import 'package:truthsoko/Pages/home/components/Search_text_field.dart';
import 'package:truthsoko/Utils/Database/productHandler.dart';
import 'package:truthsoko/src/Widget/title_text.dart';
import '../../src/Widget/constants.dart';
import '../../src/models/Product.dart';
import '../../src/models/category.dart';
import '../Details/details_screen.dart';
import '../home/components/product_card.dart';
import 'components/header.dart';

class CategoryScreen extends StatelessWidget {
  final User user;
  const CategoryScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    // TODO: implement build
    return ChangeNotifierProvider.value(
      value: SelectedCategory(),
      child: Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HomeHeader(),
              SearchWidget(searchController: searchController),
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
                      return StreamBuilder(
                          stream: ProductHandler()
                              .fetchRelatedProducts(selected.selected),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            final data = snapshot.data;
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: LoadingIndicator(
                                      indicatorType:
                                          Indicator.circleStrokeSpin));
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    "Something went wrong.........${snapshot.error}"),
                              );
                            }

                            return GridView.builder(
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                mainAxisSpacing: Global.defaultPadding,
                                crossAxisSpacing: Global.defaultPadding,
                              ),
                              padding:
                                  const EdgeInsets.only(right: 32, top: 80),
                              itemCount: data?.docs.length ?? 0,
                              itemBuilder: (context, index) {
                                ProductModel product =
                                    ProductModel.fromSnapshot(
                                        data!.docs[index]);
                                if (data.docs.isEmpty) {
                                  return const Center(
                                    child: Text(
                                        "No product fits that description"),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                        "Something went wrong.........${snapshot.error}"),
                                  );
                                }
                                return ProductCard(
                                    //index: index,
                                    product: product,
                                    percentageComplete: 1,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 700),
                                          reverseTransitionDuration:
                                              const Duration(milliseconds: 700),
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              FadeTransition(
                                            opacity: animation,
                                            child: DetailsScreen(
                                              product: product,
                                              user: user,
                                            ),
                                          ),
                                        ),
                                      );
                                    }, user: user,);
                              },
                            );
                          });
                    }),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
