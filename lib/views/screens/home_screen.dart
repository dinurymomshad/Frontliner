import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontliner/constants.dart';
import 'package:frontliner/model/drawer_items_model.dart';
import 'package:frontliner/model/home_screen_options_model.dart';
import 'package:frontliner/views/screens/login_screen.dart';
import 'package:frontliner/views/screens/my_news_screen.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
          backgroundColor: kAccentColor,
          foregroundColor: kPrimaryColor,
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
                          backgroundImage: NetworkImage(SIDE_DRAWER_AVATAR),
                        ).pOnly(bottom: 10),
                        Container(
                                padding: EdgeInsets.all(5),
                                color: kSecondaryColor,
                                child: Text("Momshad", style: CustomTextStyle.subtitle1.copyWith(color: kPrimaryColor)))
                            .pOnly(bottom: 5),
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
                child: ListView.builder(
                    itemCount: DrawerItemsModel.items.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(DrawerItemsModel.items[index].optionName),
                            leading: DrawerItemsModel.items[index].optionIcon,
                            onTap: () async {
                              if (index <= 6)
                                toast("${DrawerItemsModel.items[index].optionName} Clicked");
                              else {
                                setBool(LOGGED_IN, false);
                                await FirebaseAuth.instance.signOut();
                                context.nextAndRemoveUntilPage(LoginScreen());
                              }
                            },
                          ),
                          Divider().visible(index == 5)
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.notifications, color: kPrimaryColor),
          onPressed: () {
            toast("Notification Pressed");
          },
        ),
        body: Container(
          height: context.screenSize.height,
          color: kAccentColor.withOpacity(0.10),
          //decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/Cute Nurse.jpg"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(HOME_SCREEN_HEADER_IMAGE),
                  radius: 100,
                ).pOnly(bottom: 20, top: 20),
                GridView.builder(
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 20, mainAxisSpacing: 20),
                    shrinkWrap: true,
                    itemCount: HomeScreenOptionsModel.items.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Card(
                        color: kPrimaryColor,
                        elevation: 5,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HomeScreenOptionsModel.items[index].optionIcon.pOnly(bottom: 10),
                            Text(HomeScreenOptionsModel.items[index].optionName),
                          ],
                        ),
                      ).onInkTap(() {
                        if (index != 3) {
                          toast(HomeScreenOptionsModel.items[index].optionName + " selected");
                        } else {
                          context.nextPage(MyNewsScreen());
                        }
                      });
                    }),
              ],
            ).px20(),
          ),
        ),
      ),
    );
  }
}
