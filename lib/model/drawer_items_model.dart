import 'package:flutter/material.dart';
import 'package:frontliner/views/styles/color.dart';

class DrawerItemsModel {
  String optionName;
  Icon optionIcon;

  DrawerItemsModel({this.optionName, this.optionIcon});

  static List<DrawerItemsModel> get items => [
        DrawerItemsModel(
          optionName: "Music",
          optionIcon: Icon(Icons.library_music_outlined, color: kAccentColor),
        ),
        DrawerItemsModel(
          optionName: "Movies",
          optionIcon: Icon(Icons.movie_sharp, color: kAccentColor),
        ),
        DrawerItemsModel(
          optionName: "Shopping",
          optionIcon: Icon(Icons.shopping_cart, color: kAccentColor),
        ),
        DrawerItemsModel(
          optionName: "Apps",
          optionIcon: Icon(Icons.apps, color: kAccentColor),
        ),
        DrawerItemsModel(
          optionName: "Docs",
          optionIcon: Icon(Icons.dashboard, color: kAccentColor),
        ),
        DrawerItemsModel(
          optionName: "Settings",
          optionIcon: Icon(Icons.settings, color: kAccentColor),
        ),
        DrawerItemsModel(
          optionName: "About",
          optionIcon: Icon(Icons.info, color: kAccentColor),
        ),
        DrawerItemsModel(
          optionName: "Logout",
          optionIcon: Icon(Icons.logout, color: kAccentColor),
        )
      ];
}
