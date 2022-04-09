import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'dart:math';
import '../../../src/Widget/bezierContainer.dart';
import '../../../src/Widget/color.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final user = Provider.of<UserRepository>(context, listen: false);

    // TODO: implement build
    return Material(
      child: SafeArea(
        child: Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Global.darkGreen, Global.green],
                  begin: Alignment.topLeft),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Global.defaultPadding),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Global.defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage("assets/images/QuestionMark.jpg"),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Username",
                          style: GoogleFonts.acme(
                            fontSize: 25,
                            color: Global.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Global.yellow,
                          blurRadius: 6,
                          spreadRadius: 5,
                          offset: Offset(5, 5),
                        ),
                      ]),
                      child: ListTile(
                        leading: const Icon(
                          Icons.account_box,
                          color: Global.yellow,
                        ),
                        title: Text(
                          "My Account",
                          style: GoogleFonts.acme(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Global.yellow,
                          blurRadius: 6,
                          spreadRadius: 5,
                          offset: Offset(5, 5),
                        ),
                      ]),
                      child: const ListTile(
                        leading: Icon(
                          Icons.help_center_sharp,
                          color: Global.yellow,
                        ),
                        title: Text("My Tools"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Global.yellow,
                          blurRadius: 6,
                          spreadRadius: 5,
                          offset: Offset(5, 5),
                        ),
                      ]),
                      child: const ListTile(
                        leading: Icon(
                          Icons.info_outline_sharp,
                          color: Global.yellow,
                        ),
                        title: Text("About"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Global.yellow,
                          blurRadius: 6,
                          spreadRadius: 5,
                          offset: Offset(5, 5),
                        ),
                      ]),
                      child: const ListTile(
                        leading: Icon(
                          Icons.share_sharp,
                          color: Global.yellow,
                        ),
                        title: Text("Share App"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () => user.signOut(),
                    child: Container(
                      decoration: const BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Global.yellow,
                          blurRadius: 6,
                          spreadRadius: 5,
                          offset: Offset(5, 5),
                        ),
                      ]),
                      child: const ListTile(
                        leading: Icon(
                          Icons.logout_sharp,
                          color: Global.yellow,
                        ),
                        title: Text("SignOut"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
