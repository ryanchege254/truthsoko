// ignore_for_file: unnecessary_const

import 'dart:ui';
import 'package:flutter/material.dart';

class Global {
  static const Color orange = Color.fromARGB(255, 245, 160, 80);
  static const Color yellow = Color.fromARGB(255, 242, 221, 66);
  static const Color white = Color(0xffffffff);
  static const Color green = Color.fromARGB(255, 54, 157, 33);
  static const Color darkGreen = Color.fromARGB(255, 35, 73, 22);
  static const List validEmail = ['test@gmail.com'];
  //static const List<Color> _loadingIndicator = const [orange, green, yellow];
  static const panelTransition = Duration(milliseconds: 500);
  static const defaultPadding = 20.0;
  static const cartBarHeight = 100.0;
  static const headerHeight = 85.0;
  static const categoryHeight = 60.0;
}
