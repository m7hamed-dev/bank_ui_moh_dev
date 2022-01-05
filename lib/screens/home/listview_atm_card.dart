import 'package:bank_ui_moh_dev/components/card/atm_card.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/add_card_bank_view.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/card_bank_controller.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListViewAtmCard extends StatefulWidget {
  const ListViewAtmCard({Key? key}) : super(key: key);

  @override
  State<ListViewAtmCard> createState() => _ListViewAtmCardState();
}

class _ListViewAtmCardState extends State<ListViewAtmCard> {
  @override
  void initState() {
    super.initState();
  }

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
                  Push.toPageWithAnimation(
                    context,
                    AddCardBank(
                      isAddNewCard: false,
                      cardNumber: cards[index].get('number'),
                    ),
                  );
                },
                child: UserATMCard(
                  cardHolderName: cards[index].get('name'),
                  cardNumber: cards[index].get('number'),
                  cardExpiryDate: cards[index].get('expireDate'),
                  totalAmount:
                      0.0, //double.parse(cards[index].get('amount')) ??
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
