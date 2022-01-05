import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.color,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final Color color;
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        onPressed: onPressed,
        // minWidth: 200,
        // height: 42,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
