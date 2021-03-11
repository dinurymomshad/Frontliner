import 'package:flutter/material.dart';
import 'package:frontliner/views/screens/home_screen.dart';
import 'package:frontliner/views/styles/color.dart';
import 'package:frontliner/views/styles/textstyle.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../constants.dart';
import 'login_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    Future.delayed(Duration(seconds: 2), () async {
      context.nextReplacementPage(await getBool(LOGGED_IN, defaultValue: false) ? HomeScreen() : LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                APP_NAME.toUpperCase(),
                style: CustomTextStyle.headline5,
              ).pOnly(bottom: 10),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(kSecondaryColor)),
            ],
          ),
        ));
  }
}
