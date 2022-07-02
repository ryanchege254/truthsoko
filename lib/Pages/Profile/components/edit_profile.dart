// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Pages/Profile/components/editStateprovider.dart';
import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'package:truthsoko/src/Widget/textfield_widget.dart';
import 'package:truthsoko/src/models/textview_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../Utils/Database/handleUsers.dart';
import '../../../src/Widget/constants.dart';
import '../../../src/models/User.dart';

class EditProfile extends StatefulWidget {
  final User user;
  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin {
  // final _userhandler = UserHandler();
  late AnimationController controller;
  late Animation animate;
  @override
  Widget build(BuildContext context) {
    final phone = TextEditingController();
    final email = TextEditingController();

    @override
    void initState() {
      controller = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));

      super.initState();
    }

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animate = Tween(begin: -0.5, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    _editPasswordList() {
      return ChangeNotifierProvider(
        create: (context) => UserRepository.instance(),
        child: Builder(builder: (context) {
          final provider = Provider.of<UserRepository>(context);
          return Container(
            color: Colors.white12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Change Password",
                  style: TextStyle(fontSize: 20),
                ),
                TextFieldWidget(
                    hintText: "Enter email",
                    prefixIconData: Icons.email,
                    suffixIconData: null,
                    obscureText: false,
                    onChanged: (String) {},
                    controller: email),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    provider.resetPassword(context, email.text.trim());
                  },
                  child: const Text("Reset Password"),
                )
              ],
            ),
          );
        }),
      );
    }

    Widget _editPhoneList() {
      return Container(
        color: Colors.white12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Change Phone Number",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              color: Colors.grey,
              child: ListTile(
                subtitle: Text("Current Phone No: ${widget.user.phoneNumber}"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
                hintText: "New Phone Number",
                prefixIconData: Icons.phone_android_sharp,
                suffixIconData: null,
                obscureText: false,
                // ignore: avoid_types_as_parameter_names
                onChanged: (String) {},
                controller: phone),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
                hintText: "Enter SMS code",
                prefixIconData: Icons.local_activity_outlined,
                suffixIconData: Icons.send,
                obscureText: false,
                onChanged: (String) {},
                controller: phone),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                //_userhandler.updateUser(
                //  UserModel(phone: phone.text), widget.user.uid);
              },
              child: const Text("Submit"),
            )
          ],
        ),
      );
    }

    Widget _editEmailList() {
      return Container(
        color: Colors.white12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Change Email",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              color: Colors.grey,
              child: ListTile(
                subtitle: Text("Current Email:${widget.user.email}"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
                hintText: "New Email",
                prefixIconData: Icons.phone_android_sharp,
                suffixIconData: null,
                obscureText: false,
                onChanged: (String) {},
                controller: email),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
                hintText: "Enter code",
                prefixIconData: Icons.local_activity_outlined,
                suffixIconData: Icons.send,
                obscureText: false,
                onChanged: (string) {},
                controller: email),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                //  _userhandler.updateUser(
                // UserModel(email: email.text), widget.user.uid);
              },
              child: const Text("Submit"),
            )
          ],
        ),
      );
    }

    Widget _listTile(
      ValueChanged<ProfileEdit> onSelected,
      ProfileEdit model,
    ) {
      return Consumer<ProfileEditState>(builder: (context, edit, child) {
        return Column(
          children: [
            InkWell(
              onDoubleTap: () {
                edit.selected == ActionsWidget.Normal;
              },
              onTap: () {
                controller.reset();
                controller.forward();
                edit.onSelected(onSelected, model);
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Global.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListTile(
                  focusColor: Global.yellow,
                  title: Text(model.title!),
                  trailing: const Icon(Icons.arrow_downward),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            model.isSelected
                ? AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(controller.value * 20, 1),
                        child: child,
                      );
                    },
                    child: Consumer<ProfileEditState>(
                        builder: (context, edit, child) {
                      switch (edit.selected) {
                        case ActionsWidget.Normal:
                          return Container();
                        case ActionsWidget.EditPhone:
                          return _editPhoneList();
                        case ActionsWidget.EditPassword:
                          return _editPasswordList();
                        case ActionsWidget.EditEmail:
                          return _editEmailList();
                        case ActionsWidget.EditCountry:
                          break;
                      }
                      return Container();
                    }),
                  )
                : Container()
          ],
        );
      });
    }

    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Global.green, title: const Text("Settings")),
            body: MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(
                      value: UserRepository.instance()),
                  ChangeNotifierProvider.value(
                    value: TextviewModel(),
                  ),
                  ChangeNotifierProvider.value(value: ProfileEditState())
                ],
                child: Consumer<UserRepository>(
                  builder: (context, value, child) {
                    return StreamBuilder(
                      stream:
                          UserHandler().getUSerProfile(value.getCurrentUID()),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return Container(
                            color: const Color.fromARGB(255, 216, 216, 216),
                            padding:
                                const EdgeInsets.all(Global.defaultPadding),
                            child: Consumer<ProfileEditState>(
                                builder: (context, editstate, child) {
                              return Column(
                                children: [
                                  ListView(
                                    padding: const EdgeInsets.all(10),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: profit_model
                                        .map((model) => Column(
                                              children: [
                                                _listTile(
                                                  (model) {
                                                    editstate.itemSelected(
                                                        model, model.action!);
                                                  },
                                                  model,
                                                ),
                                              ],
                                            ))
                                        .toList(),
                                  ),
                                  //Textfield section
                                  /* AnimatedBuilder(
                                        animation: controller,
                                        builder: (context, child) {
                                          return Transform.translate(
                                            offset: Offset(controller.value * 20, 1),
                                            child: child,
                                          );
                                        },
                                        child: Consumer<ProfileEditState>(
                                            builder: (context, edit, child) {
                                          final UserModel model = UserModel();
                                          switch (edit.selected) {
                                            case ActionsWidget.Normal:
                                              return Container();
                                            case ActionsWidget.EditPhone:
                                              return _editPhoneList(model);
                                            case ActionsWidget.EditPassword:
                                              return _editPasswordList();
                                            case ActionsWidget.EditEmail:
                                              return _editEmailList(model);
                                            case ActionsWidget.EditCountry:
                                              break;
                                          }
                                          return Container();
                                        }),
                                      ) */
                                ],
                              );
                            }));
                      },
                    );
                  },
                ))));
  }
}
