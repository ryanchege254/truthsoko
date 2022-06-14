import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:truthsoko/Pages/Profile/components/Widget/productList.dart';
import 'package:truthsoko/Pages/home/components/product_card.dart';
import 'package:truthsoko/Utils/Database/productHandler.dart';
import 'package:truthsoko/src/Widget/fav_btn.dart';

import '../../../src/Widget/constants.dart';
import '../../../src/models/Product.dart';
import '../../Details/details_screen.dart';

class Saved extends StatefulWidget {
  final User user;

  const Saved({Key? key, required this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Saved();
}

class _Saved extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved"),
        backgroundColor: Global.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Global.defaultPadding),
        child: StreamBuilder(
            stream: ProductHandler().fetchSavedItems(widget.user.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(100),
                  child: Text("Something went wrong.....${snapshot.error}"),
                ));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: LoadingIndicator(
                      indicatorType: Indicator.circleStrokeSpin),
                );
              }

              return Column(
                children: [
                  Expanded(child: productlist(widget.user, snapshot)),
                ],
              );
            }),
      ),
    );
  }
}
