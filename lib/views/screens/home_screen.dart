import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontliner/constants.dart';
import 'package:frontliner/views/screens/login_screen.dart';
import 'package:frontliner/views/styles/color.dart';
import 'package:frontliner/views/styles/textstyle.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true, /*leading: Icon(Icons.menu)*/
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: DrawerHeader(
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/frontlines.jpg"), fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage("https://qph.fs.quoracdn.net/main-qimg-9315a88bd8c7806bd041ff9792922395.webp"),
                      ).pOnly(bottom: 10),
                      Container(
                          padding: EdgeInsets.all(5),
                          color: kSecondaryColor,
                          child: Text("Momshad", style: CustomTextStyle.subtitle1.copyWith(color: kPrimaryColor))).pOnly(bottom: 5),
                      Container(
                          padding: EdgeInsets.all(5),
                          color: kSecondaryColor,
                          child: Text("md.dinury@gmail.com", style: CustomTextStyle.subtitle2.copyWith(color: kPrimaryColor))),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView(padding: EdgeInsets.zero, children: [
                ListTile(
                  title: Text("Music"),
                  leading: Icon(Icons.library_music_outlined),
                  onTap: () {
                    toast("Music Clicked");
                  },
                ),
                ListTile(
                  title: Text("Movies"),
                  leading: Icon(Icons.movie_sharp),
                  onTap: () {
                    toast("Movies Clicked");
                  },
                ),
                ListTile(
                  title: Text("Shopping"),
                  leading: Icon(Icons.shopping_cart),
                  onTap: () {
                    toast("Shopping Clicked");
                  },
                ),
                ListTile(
                  title: Text("Apps"),
                  leading: Icon(Icons.apps),
                  onTap: () {
                    toast("Apps Clicked");
                  },
                ),
                ListTile(
                  title: Text("Docs"),
                  leading: Icon(Icons.dashboard),
                  onTap: () {
                    toast("Docs Clicked");
                  },
                ),
                ListTile(
                  title: Text("Settings"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    toast("Settings Clicked");
                  },
                ),
                Divider(),
                ListTile(
                  title: Text("About"),
                  leading: Icon(Icons.info),
                  onTap: () {
                    toast("About Clicked");
                  },
                ),
                ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    setBool(LOGGED_IN, false);
                    await FirebaseAuth.instance.signOut();
                    context.nextAndRemoveUntilPage(LoginScreen());
                  },
                )
              ]),
            )
          ],
        ),
      ),
      body: Container(),
    );
  }
}
