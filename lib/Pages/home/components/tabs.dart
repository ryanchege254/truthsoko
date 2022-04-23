// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tabs extends StatelessWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Consumer<TabSelected>(
        builder: (context, TabSelected tabSelected, child) {
      return ListView(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: TabModel.model
              .map(
                (model) => MyTab(
                    model: model,
                    onSelected: (model) {
                      tabSelected._itemSelected(model, model.tab);
                      print('${model.tab}');
                    }),
              )
              .toList());
    }));
  }
}

class MyTab extends StatelessWidget {
  final ValueChanged<TabModel> onSelected;
  final TabModel model;

  const MyTab({Key? key, required this.model, required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TabSelected>(
        builder: (context, selectedTab, child) {
      return InkWell(
        onTap: () {
          selectedTab._onSelected(onSelected, model);
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.name,
                style: TextStyle(
                  fontSize: model.isSelected ? 16 : 14,
                  color: model.isSelected
                      ? Colors.black
                      : const Color.fromARGB(255, 100, 100, 100),
                  fontWeight:
                      model.isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              Container(
                height: 6,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color:
                      model.isSelected ? const Color(0xFFFF5A1D) : Colors.white,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class TabModel {
  final String name;
  bool isSelected;
  TabWidget tab;
  TabModel({required this.tab, required this.name, required this.isSelected});
  static List<TabModel> model = [
    TabModel(tab: TabWidget.Favorites, name: "Favorites", isSelected: false),
    TabModel(tab: TabWidget.Recent, name: "Recent", isSelected: true),
    TabModel(tab: TabWidget.New, name: "New", isSelected: false),
  ];
}

enum TabWidget { Favorites, Recent, New }

class TabSelected extends ChangeNotifier {
  TabWidget tab = TabWidget.Recent;
  TabWidget get selected => tab;
  _onSelected(
    ValueChanged<TabModel> onSelected,
    TabModel model,
  ) {
    onSelected(model);
    notifyListeners();
  }

  _itemSelected(TabModel model, TabWidget selected) {
    for (var item in TabModel.model) {
      item.isSelected = false;
    }
    model.isSelected = true;
    tab = selected;

    notifyListeners();
  }
}
