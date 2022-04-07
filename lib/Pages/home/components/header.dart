import 'package:flutter/material.dart';

import 'package:truthsoko/src/Widget/color.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Global.headerHeight,
      color: const Color.fromARGB(28, 255, 255, 255),
      padding: const EdgeInsets.all(Global.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome!",
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                "UserName",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.black54),
              )
            ],
          ),
          const CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: const AssetImage("assets/images/QuestionMark.jpg"),
          )
        ],
      ),
    );
  }
}
