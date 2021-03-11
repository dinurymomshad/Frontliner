import 'package:flutter/material.dart';

import 'views/screens/splash_screen.dart';
import 'views/styles/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Frontliner',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
