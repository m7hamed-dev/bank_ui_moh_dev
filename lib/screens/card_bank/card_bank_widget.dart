import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:flutter/material.dart';
import 'bank_card_model.dart';

class CardBankWidget extends StatelessWidget {
  const CardBankWidget({Key? key, required this.card}) : super(key: key);
  final BanckCardModel card;

  ///
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          card.wonerName,
          style: TxtStyle.style(),
        ),
        Text(
          card.name,
          style: TxtStyle.style(),
        ),
        Text(
          card.numberCard,
          style: TxtStyle.style(),
        ),
        Text(
          card.currentAmount,
          style: TxtStyle.style(),
        ),
      ],
    );
  }
}
