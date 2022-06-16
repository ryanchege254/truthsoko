import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../src/Widget/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String about =
        "sdfghjfcxghcvjbklgfcvgbn"
        " kkojjhjnono iunoioinoin ibnoinboino ijjbniojbioj ijjboijubi jnboojjbo nojjbnolgfghhjkghvlodjkncojncoksjn vnosj vvksj vccisjc visdj vckisj v ikjs vccvkiskdjd viisjn vvoisijncosjncowjcnosdjjncosjdjncoioweujnbcviojufnvs enfcocnsocnwsbncosjddnbviosbnvosjnvoisnboisjfdncvoi";
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color.fromARGB(255, 126, 125, 125),
          child: Padding(
            padding: const EdgeInsets.all(Global.defaultPadding),
            child: Container(
              decoration: const BoxDecoration(
                color: Global.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Center(
                      child: Text(
                    "About app",
                    style: GoogleFonts.abel(fontSize: 20, color: Colors.black),
                  )),
                  Expanded(
                    child: Card(
                      elevation: 8,
                      child: Text(
                        about,
                        style: GoogleFonts.tienne(fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
