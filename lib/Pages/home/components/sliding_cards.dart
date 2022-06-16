import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Utils/Database/productHandler.dart';
import 'package:truthsoko/src/Widget/fav_btn.dart';
import 'package:truthsoko/src/models/Product.dart';
import 'dart:math' as math;

import '../../../src/Widget/constants.dart';
import '../../Details/details_screen.dart';

class SlidingCardsView extends StatefulWidget {
  final User user;
  const SlidingCardsView({Key? key, required this.user}) : super(key: key);

  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController? pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController!.addListener(() {
      setState(() => pageOffset = pageController!.page!);
    });
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: StreamBuilder(
          stream: ProductHandler().fetchRecentItems(widget.user.uid),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return PageView(
              controller: pageController,
              children: <Widget>[
                ListView.builder(
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (context, index) {
                      final ProductModel product =
                          ProductModel.fromSnapshot(snapshot.data!.docs[index]);

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text("No product"),
                        );
                      }
                      return SlidingCard(
                        product: product,
                        offset: pageOffset,
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
                                  product: product,
                                  user: widget.user,
                                ),
                              ),
                            ),
                          );
                        },
                        user: widget.user,
                      );
                    }),
              ],
            );
          }),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final User user;
  final ProductModel product;
  final VoidCallback press;
  final double offset;

  const SlidingCard({
    Key? key,
    required this.product,
    required this.offset,
    required this.press,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 150),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Global.orange, Global.white],
                  begin: Alignment.topCenter)),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: press,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(32)),
                  child: Image.asset(
                    '${product.image}',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ), /* FutureBuilder(
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
                    }))*/
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CardContent(
                  name: product.title!,
                  date: product.location!,
                  offset: gauss,
                  product: product,
                  user: user,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final ProductModel product;
  final User user;
  final String name;
  final String date;
  final double offset;

  const CardContent(
      {Key? key,
      required this.name,
      required this.date,
      required this.offset,
      required this.user,
      required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CardContentProvider>(
        create: (context) => CardContentProvider(),
        child: Consumer(
            builder: (context, CardContentProvider cardProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Transform.translate(
                  offset: Offset(8 * offset, 0),
                  child: Text(name, style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 8),
                Transform.translate(
                  offset: Offset(32 * offset, 0),
                  child: Text(
                    date,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Spacer(),
                Row(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(48 * offset, 0),
                      child: InkWell(
                        onTap: () {
                          cardProvider.onLiked = !cardProvider.onLiked;
                        },
                        child: SizedBox(
                            height: 25,
                            width: 25,
                            child: FavBtn(
                              product: product,
                              user: user,
                            )),
                      ),
                    ),
                    const Spacer(),
                    Transform.translate(
                      offset: Offset(32 * offset, 0),
                      child: Text(
                        '${product.price} KES',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                )
              ],
            ),
          );
        }));
  }
}

class CardContentProvider extends ChangeNotifier {
  get onLiked => _onLiked;
  bool _onLiked = false;
  set onLiked(value) {
    _onLiked = value;
    notifyListeners();
  }
}
