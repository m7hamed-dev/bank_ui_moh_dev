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
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        // padding: const EdgeInsets.only(right: mgDefaultPadding),
        child: CircleAvatar(
          backgroundColor: Colors.blue.shade200,
          child: Text(avatar),
        ),
      ),
    ],
  );
}
