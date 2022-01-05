import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:flutter/material.dart';

class HeaderAccount extends StatelessWidget {
  const HeaderAccount({Key? key, required this.greeting}) : super(key: key);
  final String greeting;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: TxtStyle.style(fontSize: 15.0),
          ),
          Text(
            'Welcome Back !!',
            style: TxtStyle.style(fontSize: 22.0),
          ),
        ],
      ),
    );
  }
}
