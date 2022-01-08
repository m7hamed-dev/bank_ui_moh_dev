import 'package:bank_ui_moh_dev/screens/transfer_money_view.dart';
import 'package:bank_ui_moh_dev/screens/users/users_controller.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/widgets/custom_loading.dart';
import 'package:bank_ui_moh_dev/widgets/shimmer_img.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UserController().getALL(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return const CustomLoading();
        }
        final _users = snapshot.data!.docs;
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          // padding: const EdgeInsets.symmetric(horizontal: mgDefaultPadding),
          itemCount: _users.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CardUser(user: _users[index]);
          },
        );
      },
    );
  }
}

class CardUser extends StatelessWidget {
  const CardUser({Key? key, required this.user}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> user;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Push.toPageWithAnimation(
          context,
          TransferMoney(
            currentBalance: 10.0,
            // currentCustomerId: 10,
            // currentUserCardNumebr: '12222',
            // senderName: 'me',
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const CircleAvatar(
            //   radius: 30.0,
            //   backgroundImage: NetworkImage(Constant.userImageUrl),
            // ),
            const CustomCahchedImg(
              width: 40.0,
              height: 40.0,
            ),
            const SizedBox(height: 10.0),
            Text(
              user['name'],
              style: TxtStyle.style(fontSize: 11.0),
            ),
          ],
        ),
      ),
    );
  }
}
