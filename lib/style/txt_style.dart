import 'package:flutter/material.dart';

class TxtStyle {
  static TextStyle style({Color? color}) {
    return TextStyle(
      color: color ?? Colors.black,
      fontFamily: 'ubuntu',
      // fontWeight: FontWeight.w500,
    );
  }
}
