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
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: TxtStyle.style(fontSize: 12.0, color: Colors.grey),
              ),
              Text(
                'Welcome Back !!',
                style: TxtStyle.style(fontSize: 22.0),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
              border: Border.all(width: 0.0),
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 17.0,
              backgroundImage: NetworkImage(
                Constant.userImageUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
