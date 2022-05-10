import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/src/Widget/fav_btn.dart';
import 'package:truthsoko/src/models/Product.dart';
import 'dart:math' as math;

import '../../../src/Widget/constants.dart';
import '../../Details/details_screen.dart';

class SlidingCardsView extends StatefulWidget {
  const SlidingCardsView({Key? key}) : super(key: key);

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
      child: PageView(
        controller: pageController,
        children: <Widget>[
          SlidingCard(
            product: demo_productsModel[1],
            offset: pageOffset,
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
                      product: demo_productsModel[1],
                    ),
                  ),
                ),
              );
            },
          ),
          SlidingCard(
            product: demo_productsModel[2],
            offset: pageOffset,
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
                      product: demo_productsModel[2],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final  product;
  final VoidCallback press;
  final double offset;

  const SlidingCard({
    Key? key,
    required this.product,
    required this.offset,
    required this.press,
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
                    product.image!,
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment(-offset.abs(), 0),
                    fit: BoxFit.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CardContent(
                  name: product.title!,
                  date: product.location,
                  offset: gauss,
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
  final String name;
  final String date;
  final double offset;

  const CardContent(
      {Key? key, required this.name, required this.date, required this.offset})
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
                        child: const SizedBox(
                            height: 25, width: 25, child: FavBtn()),
                      ),
                    ),
                    const Spacer(),
                    Transform.translate(
                      offset: Offset(32 * offset, 0),
                      child: const Text(
                        '0.00 \KES',
                        style: TextStyle(
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
