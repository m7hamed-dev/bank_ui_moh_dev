import 'package:flutter/material.dart';

class TxtStyle {
  static TextStyle style({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color ?? Colors.black,
      fontFamily: 'ubuntu',
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }
}
