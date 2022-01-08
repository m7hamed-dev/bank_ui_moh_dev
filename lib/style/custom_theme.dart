import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get themeData => ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        /// appBar
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          color: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      );
}
