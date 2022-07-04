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
    this.radius = 15,
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
            height: 20,
            width: 20,
            child: CircleAvatar(
              radius: radius,
              backgroundColor: const Color(0xFFE3E2E3),
              child: SvgPicture.asset(
                "assets/icons/heart.svg",
                color: context.read<FavBtnProvider>().onLiked
                    ? Global.green
                    : const Color.fromARGB(255, 179, 179, 179),
              ),
            ),
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
}
