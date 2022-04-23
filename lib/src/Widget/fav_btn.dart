import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

class FavBtn extends StatelessWidget {
  const FavBtn({
    Key? key,
    this.radius = 12,
  }) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FavBtnProvider(),
        child: Consumer(builder: (context, FavBtnProvider provider, child) {
          return InkWell(
            onTap: () {
              provider.onLiked = !provider.onLiked;
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
        }));
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
