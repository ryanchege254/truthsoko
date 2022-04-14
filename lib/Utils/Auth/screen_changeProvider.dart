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
  PageState homeState = PageState.categories;
  PageState get changeHomeState => homeState;
  get activeTab => _activeTab;
  bool _activeTab = false;
  set activeTab(value) {
    _activeTab = value;
    notifyListeners();
  }

  set changeHomeState(PageState state) {
    homeState = state;
    notifyListeners();
  }
}
