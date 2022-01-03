import 'package:flutter/material.dart';

class Push {
  static void toPage(BuildContext context, Widget page) {
    MaterialPageRoute _route = MaterialPageRoute(
      builder: (context) => page,
    );
    Navigator.push(context, _route);
  }

  static toPageWithAnimation(BuildContext context, Widget page) {
    print('toPageWithAnimation = ');
    var _route = PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 100),
        transitionsBuilder: (context, animation, animationTime, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomCenter,
            child: child,
          );
        },
        pageBuilder: (context, animation, animationTime) {
          return page;
        });
    Navigator.push(context, _route);
  }
}
