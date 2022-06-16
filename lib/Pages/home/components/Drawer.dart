import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Pages/home/home_screen.dart';
import 'package:truthsoko/Pages/screen_changeProvider.dart';
import '../../../src/Widget/constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double blurRadius = 15;
    double spreadRadius = 3;

    return Consumer<ScreenChange>(builder: (context, screenChange, child) {
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
                    const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color.fromARGB(255, 219, 230, 20)),
                    InkWell(
                      onTap: () {
                        screenChange.changeHomeState(PageState.homescreen);
                        HomeScreen.of(context)!.toggle();
                        print("${screenChange.state}");
                      },
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: screenChange.state == PageState.homescreen
                                  ? Global.orange
                                  : Colors.transparent,
                              blurRadius: blurRadius,
                              spreadRadius: spreadRadius,
                              offset: const Offset(5, 5),
                            )
                          ]),
                          child: const Icon(
                            FontAwesomeIcons.home,
                            color: Global.yellow,
                          ),
                        ),
                        title: Text(
                          "Home",
                          style: GoogleFonts.acme(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        screenChange.changeHomeState(PageState.categories);
                        HomeScreen.of(context)!.toggle();

                        print("${screenChange.state}");
                      },
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: screenChange.state == PageState.categories
                                  ? Global.orange
                                  : Colors.transparent,
                              blurRadius: blurRadius,
                              spreadRadius: spreadRadius,
                              offset: const Offset(5, 5),
                            )
                          ]),
                          child: const Icon(
                            Icons.category_sharp,
                            color: Global.yellow,
                          ),
                        ),
                        title: Text(
                          "Categories",
                          style: GoogleFonts.acme(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        screenChange.changeHomeState(PageState.account);
                        HomeScreen.of(context)!.toggle();

                        print("${screenChange.state}");
                      },
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: screenChange.state == PageState.account
                                  ? Global.orange
                                  : Colors.transparent,
                              blurRadius: blurRadius,
                              spreadRadius: spreadRadius,
                              offset: const Offset(5, 5),
                            )
                          ]),
                          child: const FaIcon(
                            Icons.verified_user_rounded,
                            color: Global.yellow,
                          ),
                        ),
                        title: Text(
                          "Profile",
                          style: GoogleFonts.acme(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: (() {
                        screenChange.changeHomeState(PageState.notification);
                        HomeScreen.of(context)!.toggle();

                        print("${screenChange.state}");
                      }),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(boxShadow: <BoxShadow>[
                            BoxShadow(
                              color:
                                  screenChange.state == PageState.notification
                                      ? Global.orange
                                      : Colors.transparent,
                              blurRadius: blurRadius,
                              spreadRadius: spreadRadius,
                              offset: const Offset(5, 5),
                            )
                          ]),
                          child: const Icon(
                            Icons.notifications,
                            color: Global.yellow,
                          ),
                        ),
                        title: Text(
                          "Notifications",
                          style: GoogleFonts.acme(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        screenChange.changeHomeState(PageState.about);
                        HomeScreen.of(context)!.toggle();

                        print("${screenChange.state}");
                      },
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: screenChange.state == PageState.about
                                  ? Global.orange
                                  : Colors.transparent,
                              blurRadius: blurRadius,
                              spreadRadius: spreadRadius,
                              offset: const Offset(5, 5),
                            )
                          ]),
                          child: const Icon(
                            Icons.info_sharp,
                            color: Global.yellow,
                          ),
                        ),
                        title: Text("About", style: GoogleFonts.acme()),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        
                        screenChange.changeHomeState(PageState.shareApp);
                        print("${screenChange.state}");
                      },
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: screenChange.state == PageState.shareApp
                                  ? Global.orange
                                  : Colors.transparent,
                              blurRadius: blurRadius,
                              spreadRadius: spreadRadius,
                              offset: const Offset(5, 5),
                            )
                          ]),
                          child: const Icon(
                            Icons.share_sharp,
                            color: Global.yellow,
                          ),
                        ),
                        title: Text("Share App", style: GoogleFonts.acme()),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
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
    });
  }
}
