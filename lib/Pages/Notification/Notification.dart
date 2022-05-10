import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truthsoko/Pages/Profile/components/header.dart';
import '../../src/Widget/constants.dart';
import 'components/messagemodel.dart';
import 'components/messagewidget.dart';

class NotificationScreen extends StatelessWidget {
  final User user;
  const NotificationScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        backgroundColor: Global.green,
        title: const Text("Notifications"),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: Global.defaultPadding,
                bottom: Global.defaultPadding,
                left: Global.defaultPadding,
                right: 50),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [Global.yellow, Global.grey])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: MessageModel.messageList.length,
                      itemBuilder: (context, index) {
                        final model = MessageModel.messageList[index];
                        return message(model);
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
