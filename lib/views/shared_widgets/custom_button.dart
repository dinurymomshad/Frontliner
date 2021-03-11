import 'package:flutter/material.dart';
import 'package:frontliner/views/styles/color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double widthMultiplier;

  const CustomButton({
    Key key,
    this.text,
    this.press,
    this.color = kSecondaryColor,
    this.textColor = kPrimaryColor,
    this.widthMultiplier = 0.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * widthMultiplier,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          padding: EdgeInsets.all(15),
          color: color,
          onPressed: press,
          child: Text(text, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }
}
