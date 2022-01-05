import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/screens/account/profile_controller.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            child: const CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(Constant.userImageUrl),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'mohamed syed',
            style: TxtStyle.style(),
          ),
          const Spacer(),
          MyButton(
            onPressed: () {
              ProfileController().logOut().then((_) {
                Push.toPageWithAnimation(context, RegistrationScreen());
              });
            },
            color: Colors.redAccent,
            title: 'logOut',
          )
        ],
      ),
    );
  }
}
