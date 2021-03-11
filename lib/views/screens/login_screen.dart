import 'package:flutter/material.dart';
import 'package:frontliner/views/shared_widgets/shared_widgets.dart';
import 'package:frontliner/views/styles/color.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                      hintText: "Your Phone",
                      icon: Icons.phone,
                      onChanged: (value) {
                        _phoneNumber = value;
                      },
                      validator: (value) => value.isEmpty ? 'This field is required' : null,
                    ),
                    CustomButton(
                        text: "LOGIN IN",
                        press: () async {
                          if (_formKey.currentState.validate()) {
                            setBool(LOGGED_IN, false);
                            hideKeyboard(context);

                            toast("Login In Successful");
                            setBool(LOGGED_IN, true);
                            //context.nextReplacementPage(BottomNavBar());

                          }
                        }).pOnly(top: 10),
                  ],
                ),
              ),
            ),
            Container(color: kSecondaryColor.withOpacity(0.5), child: CircularProgressIndicator().center().visible(isLoading)).center(),
          ],
        ),
      ),
    );
  }
}
