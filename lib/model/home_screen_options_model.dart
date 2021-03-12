import 'package:flutter/material.dart';
import 'package:frontliner/views/styles/color.dart';

class HomeScreenOptionsModel {
  String optionName;
  Icon optionIcon;

  HomeScreenOptionsModel({this.optionName, this.optionIcon});

  static List<HomeScreenOptionsModel> get items => [
    HomeScreenOptionsModel(
      optionName: "Feed Updates",
      optionIcon: Icon(Icons.update, color: kAccentColor, size: 48),
    ),
    HomeScreenOptionsModel(
      optionName: "Search Jobs",
      optionIcon: Icon(Icons.search, color: kAccentColor, size: 48),
    ),
    HomeScreenOptionsModel(
      optionName: "My Safety",
      optionIcon: Icon(Icons.privacy_tip, color: kAccentColor, size: 48),
    ),
    HomeScreenOptionsModel(
      optionName: "My News",
      optionIcon: Icon(Icons.article_outlined, color: kAccentColor, size: 48),
    )
  ];
}