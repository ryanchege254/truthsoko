// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Utils/Auth/Auth.dart';

class HomePage extends StatefulWidget {
  final User? user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserRepository>(context);

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => UserRepository.instance(),
        child: Builder(builder: (context) {
          return Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {
                          provider.signOut();
                        },
                        child: const Text("Sign Out")),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("Welcome"),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
