import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truthsoko/src/Widget/constants.dart';
import 'package:truthsoko/src/Widget/fav_btn.dart';
import 'package:truthsoko/Pages/Details/components/price.dart';
import 'package:truthsoko/src/models/Product.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 1.37,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: Image.asset(widget.product.image!),
                ),
              ],
            ),
          ),
          const SizedBox(height: Global.defaultPadding * 1.5),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Global.defaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.product.title!,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Price(
                  amount: widget.product.price.toString(),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(Global.defaultPadding),
              child: Text(
                "Cabbage (comprising several cultivars of Brassica oleracea) is a leafy green, red (purple), or white (pale green) biennial plant grown as an annual vegetable crop for its dense-leaved heads. It is descended from the wild cabbage (B. oleracea var. oleracea), and belongs to the cole crops or brassicas, meaning it is closely related to broccoli and cauliflower (var. botrytis); Brussels sprouts (var. gemmifera); and Savoy cabbage (var. sabauda).",
                style: TextStyle(
                  color: Color(0xFFBDBDBD),
                  height: 1.8,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(Global.defaultPadding),
                child: Text(
                  "Similar Products",
                  style: GoogleFonts.acme(fontSize: 20),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: demo_productsModel.length,
                      itemBuilder: (context, index) {
                        final product = demo_productsModel[index];
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
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
                                            product: demo_productsModel[index],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        gradient: LinearGradient(
                                            end: Alignment.bottomRight,
                                            begin: Alignment.topLeft,
                                            colors: [
                                              Global.green,
                                              Global.orange,
                                              Global.yellow,
                                              Global.white,
                                            ])),
                                    child: Column(children: [
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 1,
                                                    blurRadius: 12,
                                                    color: Global.white)
                                              ]),
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                      left: Radius.circular(16),
                                                      right:
                                                          Radius.circular(16)),
                                              child:
                                                  Image.asset(product.image!)),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              product.location!,
                                              style: GoogleFonts.acme(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            const SizedBox(width: 5),
                                            const Price(amount: "20.00")
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              )
                            ]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: const BackButton(
        color: Colors.black,
      ),
      backgroundColor: Global.green,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Fruits",
        style: TextStyle(color: Colors.black),
      ),
      actions: const [
        FavBtn(radius: 20),
        SizedBox(width: Global.defaultPadding),
      ],
    );
  }
}
