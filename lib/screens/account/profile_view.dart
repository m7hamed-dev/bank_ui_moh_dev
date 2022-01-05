import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(Constant.userImageUrl),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'mohamed syed',
                  style: TxtStyle.style(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
