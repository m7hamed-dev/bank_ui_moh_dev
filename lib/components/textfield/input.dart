import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.hintName,
    required this.onChanged,
    required this.keyboardTypeNumber,
  }) : super(key: key);

  final String hintName;
  final void Function(String v)? onChanged;
  final bool keyboardTypeNumber;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType:
          keyboardTypeNumber ? TextInputType.number : TextInputType.text,
      style: TxtStyle.style(),
      decoration: InputDecoration(
        hintText: hintName,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            width: 10.4,
          ),
        ),
        hintStyle: TxtStyle.style(
          color: Colors.grey,
          fontWeight: FontWeight.w100,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
