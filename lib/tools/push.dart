import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Push {
  static toPage(BuildContext context, Widget page) {
    MaterialPageRoute _route = MaterialPageRoute(
      builder: (context) => page,
    );
    Navigator.push(context, _route);
  }
}
