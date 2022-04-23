import 'package:flutter/cupertino.dart';

enum PageState {
  homescreen,
  categories,
  account,
  notification,
  about,
  shareApp
}

class ScreenChange extends ChangeNotifier {
  PageState homeState = PageState.homescreen;
  PageState get state => homeState;
  void changeHomeState(PageState state) {
    homeState = state;
    notifyListeners();
  }
}
