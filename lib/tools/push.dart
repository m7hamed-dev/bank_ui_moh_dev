import 'package:flutter/material.dart';

class Push {
  static void toPage(BuildContext context, Widget page) {
    MaterialPageRoute _route = MaterialPageRoute(
      builder: (context) => page,
    );
    Navigator.push(context, _route);
  }

  static void toPageWithAnimation(BuildContext context, Widget page,
      {Alignment? alignment}) {
    var _route = PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      transitionsBuilder: (context, animation, animationTime, child) {
        animation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );
        //
        return ScaleTransition(
          scale: animation,
          alignment: alignment ?? Alignment.center,
          child: child,
        );
      },
      pageBuilder: (context, animation, animationTime) => page,
    );
    //
    Navigator.push(context, _route);
  }
}
