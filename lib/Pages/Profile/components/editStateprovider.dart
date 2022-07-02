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
    for (var item in profit_model) {
      item.isSelected = false;
    }
    model.isSelected = true;
    action = selected;

    notifyListeners();
  }
}

class ProfileEdit {
  final String? title;
  bool isSelected;
  final ActionsWidget? action;

  ProfileEdit({this.action, this.title, required this.isSelected});
}

// ignore: non_constant_identifier_names
List<ProfileEdit> profit_model = [
  ProfileEdit(
      title: "Phone Number",
      isSelected: false,
      action: ActionsWidget.EditPhone),
  ProfileEdit(
      title: "Modify Password",
      isSelected: false,
      action: ActionsWidget.EditPassword),
  ProfileEdit(
      title: "Email", isSelected: false, action: ActionsWidget.EditEmail),
  ProfileEdit(
      title: "Select Country",
      isSelected: false,
      action: ActionsWidget.EditCountry),
];
