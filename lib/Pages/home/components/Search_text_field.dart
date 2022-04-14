import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:truthsoko/src/Widget/textfield_widget.dart';

import '../../../src/Widget/color.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.searchController,
  }) : super(key: key);
  final TextEditingController? searchController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 60,
      child: Center(
          child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
              right: Global.defaultPadding,
              left: Global.defaultPadding),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                fillColor: Global.white,
                labelStyle: const TextStyle(color: Global.white),
                focusColor: Global.orange,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: Global.yellow),
                ),
                filled: true,
                hintText: "What are you looking for...",
                prefixIcon: SizedBox(
                    width: 1,
                    height: 1,
                    child: Image.asset("assets/icons/search_2.gif"))),
          ),
        )
      ])),
    );
  }
}
