import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Utils/Auth/screen_changeProvider.dart';
import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'dart:math';
import '../../../src/Widget/bezierContainer.dart';
import '../../../src/Widget/color.dart';
import '../../Categories/Category_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ScreenChange()),
        ChangeNotifierProvider(create: (context) => UserRepository.instance())
      ],
      child: Consumer<ScreenChange>(
          builder: (context, ScreenChange screenChange, child) {
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
                      InkWell(
                        onTap: () {
                          screenChange.activeTab = !screenChange.activeTab;
                          screenChange.changeHomeState = PageState.homescreen;
                        },
                        child: ListTile(
                          leading: const Icon(
                            Icons.home_max_sharp,
                            color: Global.yellow,
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
                          screenChange.activeTab = !screenChange.activeTab;
                          screenChange.changeHomeState = PageState.categories;
                        },
                        child: ListTile(
                          leading: const Icon(
                            Icons.category_sharp,
                            color: Global.yellow,
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
                        },
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
                      const SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: (() {
                          screenChange.changeHomeState = PageState.notification;
                        }),
                        child: ListTile(
                          leading: const Icon(
                            Icons.notifications,
                            color: Global.yellow,
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
                        child: ListTile(
                          leading: const Icon(
                            Icons.info_sharp,
                            color: Global.yellow,
                          ),
                          title: Text("About", style: GoogleFonts.acme()),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        child: ListTile(
                          leading: const Icon(
                            Icons.share_sharp,
                            color: Global.yellow,
                          ),
                          title: Text("Share App", style: GoogleFonts.acme()),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ChangeNotifierProvider(
                          create: (context) => UserRepository.instance(),
                          child: Consumer<UserRepository>(
                              builder: (context, UserRepository user, child) {
                            return InkWell(
                              onTap: () => user.signOut(),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.logout_sharp,
                                  color: Global.yellow,
                                ),
                                title:
                                    Text("SignOut", style: GoogleFonts.acme()),
                              ),
                            );
                          })),
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
      }),
    );
  }
}
