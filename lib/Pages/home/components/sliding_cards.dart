import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/src/Widget/extentions.dart';
import 'dart:math' as math;

import '../../../src/Widget/color.dart';

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
            name: 'Carrots',
            date: 'Kisumu',
            assetName: 'img_1.png',
            offset: pageOffset,
          ),
          SlidingCard(
            name: 'Cabbages',
            date: 'Nairobi',
            assetName: 'img_2.png',
            offset: pageOffset - 1,
          ),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String assetName;
  final double offset;

  const SlidingCard({
    Key? key,
    required this.name,
    required this.date,
    required this.assetName,
    required this.offset,
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
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(32)),
                child: Image.asset(
                  'assets/images/$assetName',
                  height: MediaQuery.of(context).size.height * 0.3,
                  alignment: Alignment(-offset.abs(), 0),
                  fit: BoxFit.none,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: CardContent(
                  name: name,
                  date: date,
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
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: SvgPicture.asset(
                            "assets/icons/heart.svg",
                            // ignore: dead_code
                            color: context.read<CardContentProvider>().onLiked
                                ? Global.orange
                                : Global.green,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Transform.translate(
                      offset: Offset(32 * offset, 0),
                      child: const Text(
                        '0.00 \$',
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
