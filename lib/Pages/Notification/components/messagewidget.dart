import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../src/Widget/constants.dart';
import 'messagemodel.dart';

Widget message(MessageModel model) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(Global.defaultPadding),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Global.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              model.message,
              style: GoogleFonts.acme(fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(model.dateTime,
                    style: GoogleFonts.acme(color: Global.grey))
              ],
            )
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
