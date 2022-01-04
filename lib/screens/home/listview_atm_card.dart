import 'package:bank_ui_moh_dev/components/card/atmCard.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/database/databaseHelper.dart';
import 'package:bank_ui_moh_dev/model/userData.dart';
import 'package:bank_ui_moh_dev/providers/current_seleted_info_card.dart';
import 'package:bank_ui_moh_dev/providers/current_seleted_info_card.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/add_card_bank_controller.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListViewAtmCard extends StatelessWidget {
  const ListViewAtmCard({Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 199,
      color: Colors.green,
      child: StreamBuilder(
        stream: CardBankController().getALL(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          //
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: mgDefaultPadding, right: 6),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final cards = snapshot.data!.docs;
              return GestureDetector(
                onTap: () {
                  // Push.toPage(
                  //   context,
                  //   TransferMoney(
                  //     currentBalance: snapshot.data![index].totalAmount,
                  //     currentCustomerId: snapshot.data![index].id,
                  //     currentUserCardNumebr: snapshot.data![index].cardNumber,
                  //     senderName: snapshot.data![index].userName,
                  //   ),
                  // );
                },
                child: UserATMCard(
                  cardHolderName: cards[index].get('name'),
                  cardNumber: cards[index].get('name'),
                  cardExpiryDate: cards[index].get('name'),
                  totalAmount: 12.0,
                  gradientColor: null,
                  // gradientColor: _list[index].mgPrimaryGradient,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
