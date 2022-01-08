import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/database/local_storage.dart';
import 'package:bank_ui_moh_dev/screens/account/profile_controller.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/delay_animation.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'register_page.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isArabic = false;
  bool _isShowNotification = false;
  String cardNumber = '';
  // void _getCardNumberFromPrefs() {
  //   cardNumber = LocalStorage.getValueOfCardBank();
  //   if (!mounted) {
  //     return;
  //   }
  //   setState(() {});
  // }

  ///
  @override
  void initState() {
    super.initState();
    // _getCardNumberFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0),
          Text(
            'Profile View',
            style: TxtStyle.style(fontSize: 20.0),
          ),
          const SizedBox(height: 90.0),
          Center(
            child: DelayAnimation(
              duration: const Duration(milliseconds: 600),
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                child: const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(Constant.userImageUrl),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'moh94syed@gmail.com',
            style: TxtStyle.style(fontSize: 20.0),
          ),
          Text(
            '+249 929469784',
            style: TxtStyle.style(
              fontSize: 15.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20.0),
          Divider(
            indent: 50,
            endIndent: 50.0,
            thickness: 8.0,
            color: Colors.grey.shade200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                isArabic ? 'arabic' : 'english',
                style: TxtStyle.style(
                  fontSize: 15.0,
                  color: isArabic ? Colors.black : Colors.grey,
                ),
              ),
              Switch.adaptive(
                value: isArabic,
                onChanged: (value) {
                  isArabic = !isArabic;
                  setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Divider(
            indent: 50,
            endIndent: 50.0,
            thickness: 8.0,
            color: Colors.grey.shade200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                _isShowNotification ? 'show' : 'hide',
                style: TxtStyle.style(
                  fontSize: 15.0,
                  color: _isShowNotification ? Colors.black : Colors.grey,
                ),
              ),
              Switch.adaptive(
                value: _isShowNotification,
                onChanged: (value) {
                  _isShowNotification = !_isShowNotification;
                  setState(() {});
                },
              ),
            ],
          ),
          cardNumber.isNotEmpty
              ? QrImage(
                  data: cardNumber,
                  version: QrVersions.auto,
                  size: 150.0,
                )
              : const SizedBox(),
          const Spacer(),
          DelayAnimation(
            duration: const Duration(milliseconds: 600),
            child: MyButton(
              onPressed: () {
                ProfileController().logOut().then((_) {
                  Push.toPageWithAnimation(context, const RegistrationScreen());
                });
              },
              color: Colors.redAccent,
              title: 'logOut',
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
