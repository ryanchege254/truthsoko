import 'package:flutter/material.dart';
import 'dart:math';
import '../../../src/Widget/bezierContainer.dart';
import '../../../src/Widget/color.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Material(
      child: SafeArea(
        child: Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Global.green, Global.white],
                        begin: AlignmentDirectional.bottomCenter)),
              ),
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: const BezierContainer()),
            ],
          ),
        ),
      ),
    );
  }
}
