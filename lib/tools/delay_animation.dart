import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class DelayAnimation extends StatelessWidget {
  const DelayAnimation({
    Key? key,
    required this.child,
    required this.duration,
    this.slidingCurve,
  }) : super(key: key);
  final Widget child;
  final Duration duration;
  final Curve? slidingCurve;
  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      slidingCurve: slidingCurve ?? Curves.easeInOutCirc,
      delay: duration,
      child: child,
    );
  }
}
