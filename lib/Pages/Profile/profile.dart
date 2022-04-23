import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Pages/Profile/components/edit_profile.dart';
import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'package:truthsoko/src/Widget/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider.value(
        value: UserRepository.instance(),
        child: Scaffold(
          body: Center(
            child: Stack(
              children: [
                Container(
                  color: Color.fromARGB(255, 228, 228, 228),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 55, bottom: 15),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                                gradient: LinearGradient(
                                    colors: [Global.green, Global.orange])),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                        "assets/images/QuestionMark.jpg"),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Username",
                                        style: GoogleFonts.acme(
                                          fontSize: 25,
                                          color: Global.white,
                                        ),
                                      ),
                                      Text(
                                        "user-email@gmail.com",
                                        style: GoogleFonts.acme(
                                          color: Global.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Global.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding:
                                const EdgeInsets.all(Global.defaultPadding),
                            margin: const EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ProfileWidget(
                                    label: "Tools",
                                    icon: FontAwesomeIcons.toolbox,
                                    onClick: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 500),
                                          reverseTransitionDuration:
                                              const Duration(milliseconds: 500),
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              FadeTransition(
                                                  opacity: animation,
                                                  child:EditProfile()),
                                        ),
                                      );
                                    },
                                  ),
                                  ProfileWidget(
                                    label: "Help",
                                    icon: Icons.question_answer_sharp,
                                    onClick: () {},
                                  ),
                                  ProfileWidget(
                                    label: "Recently Viewed",
                                    icon: Icons.recent_actors_sharp,
                                    onClick: () {},
                                  )
                                ]),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Divider(
                                height: 1, thickness: 1, color: Global.green),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Global.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding:
                                const EdgeInsets.all(Global.defaultPadding),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ProfileWidget(
                                    label: "Saved Items",
                                    icon: Icons.save_alt_sharp,
                                    onClick: () {},
                                  ),
                                  ProfileWidget(
                                    label: "Suggestions",
                                    icon: Icons.settings_suggest_sharp,
                                    onClick: () {},
                                  ),
                                  ProfileWidget(
                                    label: "Inbox",
                                    icon: Icons.messenger_sharp,
                                    onClick: () {},
                                  )
                                ]),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Divider(
                                height: 1, thickness: 1, color: Global.green),
                          ),
                        ],
                      ),
                      Consumer<UserRepository>(builder: (context, user, child) {
                        return InkWell(
                          onTap: () {
                            user.signOut();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 45, right: 45),
                            margin: const EdgeInsets.all(Global.defaultPadding),
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      offset: Offset.fromDirection(4),
                                      color: Colors.grey,
                                      blurRadius: 6,
                                      spreadRadius: 5)
                                ],
                                color: Global.green,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.signOutAlt,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Sign Out",
                                    style: GoogleFonts.acme(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onClick})
      : super(key: key);
  final String label;
  final IconData icon;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        InkWell(
          onTap: onClick,
          child: Container(
            child: Icon(
              icon,
              size: 35,
              color: Global.yellow,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(label, style: GoogleFonts.acme())
      ],
    );
  }
}
