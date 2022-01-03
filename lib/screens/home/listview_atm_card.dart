import 'package:bank_ui_moh_dev/components/card/atmCard.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/database/databaseHelper.dart';
import 'package:bank_ui_moh_dev/model/userData.dart';
import 'package:bank_ui_moh_dev/providers/current_seleted_info_card.dart';
import 'package:bank_ui_moh_dev/providers/current_seleted_info_card.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../transferMoney.dart';

class ListViewAtmCard extends StatelessWidget {
  const ListViewAtmCard({Key? key, required this.databaseHelper})
      : super(key: key);
  final DatabaseHelper databaseHelper;
  @override
  Widget build(BuildContext context) {
    final _selectedCard = context.read<CurrentSeletedInfoCardProvider>();
    return Container(
      height: 199,
      color: Colors.green,
      child: FutureBuilder<List<UserData>>(
        initialData: const [],
        future: databaseHelper.getUserDetails(),
        builder: (context, snapshot) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: mgDefaultPadding, right: 6),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _selectedCard.seletedUser(snapshot.data![index]);
                  Push.toPage(
                    context,
                    TransferMoney(
                      currentBalance: snapshot.data![index].totalAmount,
                      currentCustomerId: snapshot.data![index].id,
                      currentUserCardNumebr: snapshot.data![index].cardNumber,
                      senderName: snapshot.data![index].userName,
                    ),
                  );
                },
                child: UserATMCard(
                  // cardHolderName: 'card home mohamed',
                  cardHolderName: snapshot.data![index].userName,
                  cardNumber: snapshot.data![index].cardNumber,
                  cardExpiryDate: snapshot.data![index].cardExpiry,
                  totalAmount: snapshot.data![index].totalAmount,
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
