import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontliner/views/screens/home_screen.dart';
import 'package:frontliner/views/shared_widgets/shared_widgets.dart';
import 'package:frontliner/views/styles/color.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId;
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void verifyPhoneNumber() async {
    //Callback for when the user has already previously signed in with this phone number on this device
    PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      showSnackBar("Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
    };
    //Listens for errors with verification, such as too many attempts
    PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException) {
      showSnackBar('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    //Callback for when the code is sent
    PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      showSnackBar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      showSnackBar("verification code: " + verificationId);
      setState(() {
        _verificationId = verificationId;
        isLoading = false;
      });
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumberController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar("Failed to Verify Phone Number: $e");
    }
  }

  void signInWithPhoneNumber() async {
    setState(() {
      isLoading = true;
    });
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;
      setState(() {
        isLoading = false;
      });
      showSnackBar("Successfully signed in UID: ${user.uid}");
      setBool(LOGGED_IN, true);
      context.nextReplacementPage(HomeScreen());
    } catch (e) {
      showSnackBar("Failed to sign in: " + e.toString());
    }
  }

  void showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      hintText: "Phone number",
                      icon: Icons.phone,
                      controller: _phoneNumberController,
                      validator: (value) => value.isEmpty ? 'This field is required' : null,
                    ),
                    CustomTextField(
                      hintText: "OTP",
                      icon: Icons.smartphone_sharp,
                      controller: _smsController,
                      validator: (value) => value.isEmpty ? 'This field is required' : null,
                    ).visible(_verificationId != null),
                    CustomButton(
                        text: _verificationId == null ? "VERIFY" : "LOGIN IN",
                        press: () async {
                          if (_formKey.currentState.validate()) {
                            setBool(LOGGED_IN, false);
                            hideKeyboard(context);
                            setState(() {
                              isLoading = true;
                            });
                            _verificationId == null ? verifyPhoneNumber() : signInWithPhoneNumber();
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
