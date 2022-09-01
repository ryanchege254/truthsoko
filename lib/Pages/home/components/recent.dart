import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:truthsoko/Utils/Database/productHandler.dart';

import '../../../src/Widget/constants.dart';
import '../../../src/Widget/fav_btn.dart';
import '../../Details/components/price.dart';
import '../../../src/models/Product.dart';
import '../../Details/details_screen.dart';

class Recent extends StatelessWidget {
  final User user;
  const Recent({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productHandler = ProductHandler();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Products").snapshots(),
          /* productHandler.fetchSavedItems(user.uid), */
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print("Error.............${snapshot.error}");
              return Text("Something went wrong ... .. ${snapshot.error}");
            }
            return Container(
                padding: const EdgeInsets.all(Global.defaultPadding),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    ProductModel product =
                        ProductModel.fromSnapshot(snapshot.data!.docs[index]);
                    if (snapshot.data!.docs.isEmpty) {
                      print("Error..............${snapshot.error}");
                      return Center(
                        child: Text("Error...............${snapshot.error}"),
                      );
                    }
                    return RecentCard(
                      percentageComplete: 0,
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
                                user: user,
                              ),
                            ),
                          ),
                        );
                      },
                      product: product,
                      user: user,
                    );
                  },
                ));
          }),
    );
  }
}

class RecentCard extends StatelessWidget {
  final User user;
  final ProductModel product;
  final double percentageComplete;
  final VoidCallback press;
  const RecentCard({
    Key? key,
    required this.product,
    required this.percentageComplete,
    required this.press,
    required this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 150, left: 15, right: 15, top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 3,
            blurRadius: 8,
          )
        ],
        gradient: LinearGradient(
            end: Alignment.bottomRight,
            begin: Alignment.topLeft,
            colors: [
              Global.green,
              Global.orange,
              Global.yellow,
              Global.white,
            ]),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(spreadRadius: 1, blurRadius: 50, color: Global.white)
              ]),
              child: InkWell(
                onTap: press,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: FutureBuilder(
                    future: ProductModel().getImage(context, product.image!),
                    builder: (context, AsyncSnapshot<Widget> snapshot) {
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
                    },
                    //Image.asset(product.image!),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 40, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product.title ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      product.location ?? "",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      product.category ?? "",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Price(amount: product.price ?? ""),
                        const SizedBox(
                          width: 35,
                        ),
                        Hero(
                            tag: product.image!,
                            child: FavBtn(
                              product: product,
                              user: user,
                            )),
                      ],
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
}
