import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truthsoko/src/Widget/constants.dart';

class WarningText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const WarningText(
      {Key? key,
      required this.text,
      this.fontSize = 12,
      this.color = Global.orange,
      this.fontWeight = FontWeight.w800})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.mulish(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}
