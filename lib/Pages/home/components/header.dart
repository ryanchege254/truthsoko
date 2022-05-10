import 'package:flutter/material.dart';
import 'package:truthsoko/Pages/home/home_screen.dart';

import 'package:truthsoko/src/Widget/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    /*required this.toggle*/
  }) : super(key: key);
  //final Function toggle;
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'Tru',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 69, 148, 23)),
          children: [
            TextSpan(
              text: 'th',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            TextSpan(
              text: 'Soko',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 15),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Global.yellow, Global.white],
        begin: Alignment.topRight,
      )),
      height: Global.headerHeight,
      padding: const EdgeInsets.only(
          right: Global.defaultPadding,
          bottom: 10,
          left: Global.defaultPadding,
          top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {HomeScreen.of(context)!.toggle();},
              ),
              const SizedBox(
                width: 10,
              ),
              _title()
            ],
          ),
          const CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/images/QuestionMark.jpg"),
          )
        ],
      ),
    );
  }
}
