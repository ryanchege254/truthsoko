// ignore: file_names
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:truthsoko/Pages/home/components/product_card.dart';
import 'package:truthsoko/Utils/Database/productHandler.dart';

import '../../../src/Widget/constants.dart';
import '../../../src/models/Product.dart';
import '../../Details/details_screen.dart';

class ProductBottomSheet extends StatefulWidget {
  final User user;
  const ProductBottomSheet({Key? key, required this.user}) : super(key: key);

  @override
  _ProductBottomSheet createState() => _ProductBottomSheet();
}

class _ProductBottomSheet extends State<ProductBottomSheet> {
  double initialPercentage = 0.15;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DraggableScrollableSheet(
        minChildSize: initialPercentage,
        initialChildSize: initialPercentage,
        builder: (context, scrollController) {
          return AnimatedBuilder(
            animation: scrollController,
            builder: (context, child) {
              double percentage = initialPercentage;
              if (scrollController.hasClients) {
                percentage = (scrollController.position.viewportDimension) /
                    (MediaQuery.of(context).size.height);
              }
              double scaledPercentage =
                  (percentage - initialPercentage) / (1 - initialPercentage);
              return Container(
                padding: const EdgeInsets.only(left: 32),
                decoration: const BoxDecoration(
                  color: Global.darkGreen,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Products")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      final data = snapshot.data;
                      if (snapshot.hasError) {
                        return Center(
                            child: Padding(
                          padding: const EdgeInsets.all(100),
                          child: Text(
                              "Something went wrong.....${snapshot.error}"),
                        ));
                      }

                      return Stack(
                        children: <Widget>[
                          Opacity(
                              opacity: percentage == 1 ? 1 : 0,
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.75,
                                  mainAxisSpacing: Global.defaultPadding,
                                  crossAxisSpacing: Global.defaultPadding,
                                ),
                                padding:
                                    const EdgeInsets.only(right: 32, top: 128),
                                controller: scrollController,
                                itemCount: snapshot.data?.docs.length ?? 0,
                                itemBuilder: (context, index) {
                                  final product = ProductModel.fromSnapshot(
                                      data!.docs[index]);
                                  return ProductCard(
                                      //index:index,
                                      product: product,
                                      percentageComplete: percentage,
                                      press: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: const Duration(
                                                milliseconds: 500),
                                            reverseTransitionDuration:
                                                const Duration(
                                                    milliseconds: 500),
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                FadeTransition(
                                              opacity: animation,
                                              child: DetailsScreen(
                                                product: product,
                                                user: widget.user,
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              )),
                          ...demo_productsModel.map((product) {
                            int index = demo_productsModel.indexOf(product);
                            int heightPerElement = 120 + 8 + 8;
                            double widthPerElement =
                                40 + percentage * 80 + 8 * (1 - percentage);
                            double leftOffset = widthPerElement *
                                (index > 4 ? index + 2 : index) *
                                (1 - scaledPercentage);
                            return Positioned(
                              top: 44.0 +
                                  scaledPercentage * (128 - 44) +
                                  index * heightPerElement * scaledPercentage,
                              left: leftOffset,
                              right: 32 - leftOffset,
                              child: IgnorePointer(
                                ignoring: true,
                                child: Opacity(
                                  opacity: percentage == 1 ? 0 : 1,
                                  child: MyProductItem(
                                      product: product,
                                      percentageCompleted: percentage),
                                ),
                              ),
                            );
                          }),
                          SheetHeader(
                            fontSize: 14 + percentage * 8,
                            topMargin: 16 +
                                percentage * MediaQuery.of(context).padding.top,
                          ),
                          MenuButton(
                            press: () {
                              scrollController;
                            },
                          ),
                        ],
                      );
                    }),
              );
            },
          );
        },
      ),
    );
  }
}

class MyProductItem extends StatelessWidget {
  final ProductModel product;
  final double percentageCompleted;

  const MyProductItem(
      {Key? key, required this.product, required this.percentageCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Transform.scale(
        alignment: Alignment.topLeft,
        scale: 1 / 3 + 2 / 3 * percentageCompleted,
        child: SizedBox(
          height: 120,
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: const Radius.circular(16),
                  right: Radius.circular(16 * (1 - percentageCompleted)),
                ),
                child: Image.asset(
                  '${product.image}',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Opacity(
                  opacity: max(0, percentageCompleted * 2 - 1),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(16)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: _buildContent(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Text(product.title.toString(), style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Text(
              'Location',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              '4.20-30',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            Icon(Icons.place, color: Colors.grey.shade400, size: 16),
            Text(
              'Science Park 10 25A',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            )
          ],
        )
      ],
    );
  }
}

final List<Event> events = [
  Event('img_1.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_2.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_3.png', 'Dawan District Guangdong Hong Kong', '4.28-31'),
  Event('img_1.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_2.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_3.png', 'Dawan District Guangdong Hong Kong', '4.28-31'),
  Event('img_4.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_1.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_2.png', 'Dawan District Guangdong Hong Kong', '4.28-31'),
  Event('img_3.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_4.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_1.png', 'Dawan District Guangdong Hong Kong', '4.28-31'),
  Event('img_2.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_3.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_4.png', 'Dawan District Guangdong Hong Kong', '4.28-31'),
  Event('img_1.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_2.png', 'Shenzhen GLOBAL DESIGN AWARD 2018', '4.20-30'),
  Event('img_3.png', 'Dawan District Guangdong Hong Kong', '4.28-31'),
];

class Event {
  final String assetName;
  final String title;
  final String date;

  Event(this.assetName, this.title, this.date);
}

class SheetHeader extends StatelessWidget {
  final double fontSize;
  final double topMargin;

  const SheetHeader({Key? key, required this.fontSize, required this.topMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 32,
      child: IgnorePointer(
        child: Container(
          padding: EdgeInsets.only(top: topMargin, bottom: 12),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 35, 73, 22),
          ),
          child: Text(
            'Recommended',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  MenuButton({Key? key, required this.press}) : super(key: key);
  VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return const Positioned(
      right: 12,
      bottom: 24,
      child: Icon(
        Icons.menu,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}
