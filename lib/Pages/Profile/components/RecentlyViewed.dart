import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truthsoko/src/Widget/productList.dart';
import 'package:truthsoko/Utils/Database/productHandler.dart';
import 'package:truthsoko/src/models/Product.dart';

import '../../../src/Widget/constants.dart';
import '../../../src/Widget/fav_btn.dart';

class RecentlyViewed extends StatefulWidget {
  final User user;
  const RecentlyViewed({Key? key, required this.user}) : super(key: key);

  @override
  State<RecentlyViewed> createState() => RecentlyViewedState();
}

class RecentlyViewedState extends State<RecentlyViewed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recently viewed"),
        backgroundColor: Global.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(widget.user.uid)
              .collection("SavedItems")
              .snapshots(),
          builder: (context, snapshot) {
            //final data = snapshot.data!.docs;
            if (snapshot.hasError) {
              print(
                  "SnapshotError...........................${snapshot.error}");
            }
            return Column(
              children: [
                Expanded(child: productlist(widget.user, snapshot))
              ],
            );
          }),
    );
  }

  Widget productCard(ProductModel product) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Global.grey))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Image.asset(
                  product.image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(product.title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            )),
                        const SizedBox(width: 8),
                        Text(
                          product.location!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      product.category!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Text("KES ${product.price.toString()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Global.darkGreen,
                      ))),
              FavBtn(
                product: product,
                user: widget.user,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
