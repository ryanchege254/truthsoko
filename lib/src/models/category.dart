// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

enum CategoryTab { Vegatables, Legumes, Fruits, Cereals, Herbs }

class Category {
  String? id;
  CategoryTab? tab;
  String? name;
  String? image;
  bool? isSelected;
  Category({
    this.tab,
    this.id,
    this.name,
    this.isSelected,
    this.image,
  });


  //Example of category
  static List<Category> categoryList = [
    // Category(id: 0, image: '', name: ''),
    Category(
        id: "vegetables",
        name: "Vegetables",
        image: 'assets/images/categories/carrot.png',
        isSelected: true),
    Category(
        id: "legumes",
        name: "Legumes",
        image: 'assets/images/categories/finepeas.png',
        isSelected: false),
    Category(
        id: "fruits",
        name: "Fruits",
        image: 'assets/images/categories/fruits.png',
        isSelected: false),
    Category(
        id: "cereals",
        name: "Cereals",
        image: 'assets/images/categories/wheatseed.png',
        isSelected: false),
    Category(
        id: "herbs",
        name: "Herbs",
        image: 'assets/images/categories/rosemary.png',
        isSelected: false),
  ];
}
