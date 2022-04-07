import 'package:flutter/material.dart';
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
    return Container(
      child: Center(
          child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(Global.defaultPadding),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              fillColor: Global.white,
              labelStyle: const TextStyle(color: Global.white),
              focusColor: Global.orange,
              filled: true,
              hintText: "What are you looking for...",
              prefixIcon: const Icon(
                Icons.search,
                size: 18,
                color: Global.green,
              ),
            ),
          ),
        )
      ])),
    );
  }
}
