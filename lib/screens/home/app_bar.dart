import 'package:flutter/material.dart';

PreferredSizeWidget myAppBar(String avatar) {
  // var mgDefaultPadding;
  var mgMenuColor;
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      // padding: const EdgeInsets.only(left: mgDefaultPadding),
      child: Icon(
        Icons.menu,
        color: mgMenuColor,
        size: 35,
      ),
    ),
  );
}
