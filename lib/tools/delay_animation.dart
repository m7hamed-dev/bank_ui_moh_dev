import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class DelayAnimation extends StatelessWidget {
  const DelayAnimation({
    Key? key,
    required this.child,
    required this.duration,
  }) : super(key: key);
  final Widget child;
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      slidingCurve: Curves.easeInOut,
      delay: duration,
      child: child,
    );
  }
}
