import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final double? elevation;
  final double? radius;
  // final Color? textColor;
  const MyBtn({
    Key? key,
    this.onPressed,
    this.child,
    this.color,
    this.margin,
    this.width,
    this.elevation,
    this.padding,
    this.radius,
    this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        onLongPress: () {},
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: elevation ?? .5,
          padding: padding,
          textStyle: const TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 5.0),
          ),
        ),
      ),
    );
  }
}
