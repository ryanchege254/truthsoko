import 'package:flutter/material.dart';
import 'package:truthsoko/src/Widget/constants.dart';

class Price extends StatelessWidget {
  const Price({
    Key? key,
    required this.amount,
  }) : super(key: key);
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "KES ",
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(fontWeight: FontWeight.w600, color: Global.green),
        children: [
          TextSpan(
            text: amount,
            style: const TextStyle(color: Colors.black),
          ),
          const TextSpan(
            text: " /kg",
            style:
                TextStyle(color: Colors.black26, fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
