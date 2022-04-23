import 'package:google_fonts/google_fonts.dart';
import 'package:truthsoko/Pages/Categories/components/category.dart';
import 'package:flutter/material.dart';
import 'package:truthsoko/Pages/home/components/Search_text_field.dart';
import '../../src/Widget/constants.dart';
import '../../src/models/Product.dart';
import '../deatils/details_screen.dart';
import '../home/components/product_card.dart';
import 'components/header.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    // TODO: implement build
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const HomeHeader(),
            SearchWidget(searchController: searchController),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: Global.defaultPadding),
              child: Text("Categories",
                  style: GoogleFonts.acme(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const Categories(),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    gradient: LinearGradient(
                        colors: [Global.darkGreen, Global.yellow])),
                padding: const EdgeInsets.all(Global.defaultPadding),
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: Global.defaultPadding,
                    crossAxisSpacing: Global.defaultPadding,
                  ),
                  padding: const EdgeInsets.only(right: 32, top: 80),
                  itemCount: demo_products.length,
                  itemBuilder: (context, index) {
                    Product product = demo_products[index % 3];
                    return ProductCard(
                        index: index,
                        product: product,
                        percentageComplete: 1,
                        press: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
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
