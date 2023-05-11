import 'package:flutter/material.dart';

const int baseRed     = 0xFFCD202C;
const int lightGrey   = 0xFFCCCCCC;
const int darkGrey    = 0xFF4D4D4D;
const int appGrey     = 0xFF8C8C8C;
const backgroundWhite = 0xFFE5E5E5;

Widget titleText(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Color(darkGrey)
    ),
  );
}

TextSpan baseTextSpan(String text, bool isBold) {
  return TextSpan(
    text: text,
    style: TextStyle(
        fontSize: 18,
        color: Color(appGrey),
        fontWeight: !isBold ? FontWeight.normal : FontWeight.bold
    ),
  );
}