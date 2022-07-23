import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:truthsoko/Utils/Database/productHandler.dart';
import 'package:truthsoko/src/Widget/constants.dart';
import 'package:truthsoko/src/Widget/fav_btn.dart';
import 'package:truthsoko/Pages/Details/components/price.dart';
import 'package:truthsoko/src/models/Product.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
    required this.user,
  }) : super(key: key);
  final User user;
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
                SizedBox(
                  width: double.infinity,
                  child: FutureBuilder(
                      future: ProductModel()
                          .getImage(context, widget.product.image!),
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
                      })),
                ),
              ],
            ),
          ),
          const SizedBox(height: Global.defaultPadding * 1.5),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Global.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.title!,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.w100),
                      ),
                    ),
                    Price(
                      amount: widget.product.price.toString(),
                    ),
                  ],
                ),
                Text(
                  widget.product.location!,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          /* const Expanded(
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
          ),*/
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
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Products")
                            .where("category",
                                isEqualTo: widget.product.category)
                            .where("location",
                                isEqualTo: widget.product.location)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          final data = snapshot.data;
                          if (snapshot.hasError) {
                            print(
                                ".................snapshot error: ${snapshot.error}");
                            return const Center(
                              child: Text("Something went wrong"),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data?.docs.length ?? 0,
                            itemBuilder: (context, index) {
                              final ProductModel product =
                                  ProductModel.fromSnapshot(data!.docs[index]);
                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 700),
                                              reverseTransitionDuration:
                                                  const Duration(
                                                      milliseconds: 700),
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
                                                  borderRadius: const BorderRadius
                                                          .horizontal(
                                                      left: Radius.circular(16),
                                                      right:
                                                          Radius.circular(16)),
                                                  child: FutureBuilder(
                                                      future: ProductModel()
                                                          .getImage(context,
                                                              product.image!),
                                                      builder: ((context,
                                                          AsyncSnapshot<Widget>
                                                              snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          return Container(
                                                            child:
                                                                snapshot.data,
                                                          );
                                                        }
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          return const LoadingIndicator(
                                                            indicatorType: Indicator
                                                                .circleStrokeSpin,
                                                          );
                                                        }
                                                        return Container();
                                                      })),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    product.title!,
                                                    style: GoogleFonts.acme(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  Text(
                                                    product.location!,
                                                    style: GoogleFonts.acme(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Price(amount: product.price!)
                                                ],
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    )
                                  ]);
                            },
                          );
                        }),
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
      title: Text(
        widget.product.category!,
        style: const TextStyle(color: Colors.black),
      ),
      actions: [
        FavBtn(
          radius: 30,
          product: widget.product,
          user: widget.user,
        ),
        const SizedBox(width: Global.defaultPadding),
      ],
    );
  }
}
