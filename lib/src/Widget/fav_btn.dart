import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'package:truthsoko/Utils/Database/productHandler.dart';
import 'package:truthsoko/src/models/Product.dart';

import 'constants.dart';

class FavBtn extends StatelessWidget {
  final User user;
  final ProductModel product;
  const FavBtn({
    Key? key,
    this.radius = 25,
    required this.product,
    required this.user,
  }) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => FavBtnProvider())),
        ChangeNotifierProvider(create: (context) => ProductHandler()),
      ],
      child: Consumer<FavBtnProvider>(builder: (context, provider, child) {
        final handler = Provider.of<ProductHandler>(context);

        return InkWell(
          onTap: () async {
            provider.onLiked = !provider.onLiked;
            if (await provider.onLiked) {
              await handler
                  .saveProduct(user.uid, product)
                  .then((value) => print("...........product saved"));
            } else if (!await provider.onLiked) {
              await handler
                  .unsaveProduct(product, user.uid)
                  .then((value) => print("..........product deleted"));
            }
          },
          child: SizedBox(
            height: 25,
            width: 25,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(user.uid)
                    .collection("SavedItems")
                    .doc(product.documentId)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  return CircleAvatar(
                      radius: radius,
                      backgroundColor: const Color(0xFFE3E2E3),
                      child: SvgPicture.asset(
                        "assets/icons/heart.svg",
                        width: 20,
                        height: 20,
                        color: snapshot.hasData
                            ? Global.green
                            : const Color.fromARGB(255, 179, 179, 179),
                      ));
                }),
          ),
        );
      }),
    );
  }
}

class FavBtnProvider extends ChangeNotifier {
  get onLiked => _onLiked;
  bool _onLiked = false;
  set onLiked(value) {
    _onLiked = value;
    notifyListeners();
  }

  bool checkSavedStatus(String firebaseUser, ProductModel productModel) {
    final Stream<DocumentSnapshot<Map<String, dynamic>>> snapshot =
        FirebaseFirestore.instance
            .collection("Users")
            .doc(firebaseUser)
            .collection("SavedItems")
            .doc(productModel.documentId)
            .snapshots();

    return true;
  }
}
