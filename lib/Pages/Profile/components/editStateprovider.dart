// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum ActionsWidget { Normal, EditPhone, EditPassword, EditEmail, EditCountry }

class ProfileEditState extends ChangeNotifier {
  ActionsWidget action = ActionsWidget.Normal;
  ActionsWidget get selected => action;
  onSelected(
    ValueChanged<ProfileEdit> onSelected,
    ProfileEdit model,
  ) {
    onSelected(model);
    notifyListeners();
  }

  itemSelected(ProfileEdit model, ActionsWidget selected) {
    for (var item in ProfileEdit.model) {
      item.isSelected = false;
    }
    model.isSelected = true;
    action = selected;

    notifyListeners();
  }
}

class ProfileEdit {
  final String title;
  final String subtitle;
  bool isSelected;
  final ActionsWidget action;

  ProfileEdit(
      {required this.action,
      required this.subtitle,
      required this.title,
      required this.isSelected});
  static List<ProfileEdit> model = [
    ProfileEdit(
        subtitle: "0713344566",
        title: "Phone Number",
        isSelected: false,
        action: ActionsWidget.EditPhone),
    ProfileEdit(
        title: "Modify Password",
        isSelected: true,
        subtitle: '',
        action: ActionsWidget.EditPassword),
    ProfileEdit(
        title: "Email",
        isSelected: false,
        subtitle: 'user-email@gmail.com',
        action: ActionsWidget.EditEmail),
    ProfileEdit(
        title: "Select Country",
        isSelected: false,
        subtitle: 'Kenya',
        action: ActionsWidget.EditCountry),
    ProfileEdit(
        title: "",
        isSelected: false,
        subtitle: '',
        action: ActionsWidget.Normal),
  ];
}
