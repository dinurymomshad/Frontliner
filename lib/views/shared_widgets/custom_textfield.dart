import 'package:flutter/material.dart';
import 'package:frontliner/views/styles/color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final FormFieldValidator validator;
  final String initialValue;
  final bool isPassword;
  final double widthMultiplier;
  final Color color;
  final TextEditingController controller;

  CustomTextField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.isPassword = false,
    this.controller,
    this.widthMultiplier = 0.8,
    this.color = kSecondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width * widthMultiplier,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? true : false,
        initialValue: initialValue,
        validator: validator,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        style: TextStyle(color: kPrimaryColor),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: kPrimaryColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
