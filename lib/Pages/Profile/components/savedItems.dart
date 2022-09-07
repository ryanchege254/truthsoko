import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:truthsoko/src/Widget/productList.dart';
import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'package:truthsoko/Utils/Database/productHandler.dart';
import '../../../src/Widget/constants.dart';

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
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(widget.user.uid)
                  .collection("SavedItems")
                  .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print("...............................${snapshot.error}");

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
