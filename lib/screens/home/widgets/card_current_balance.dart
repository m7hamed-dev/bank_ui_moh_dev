import 'package:bank_ui_moh_dev/screens/card_bank/bank_card_model.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:flutter/material.dart';

class CardCurrentBalance extends StatelessWidget {
  const CardCurrentBalance({Key? key, required this.banckCardModel})
      : super(key: key);
  final BanckCardModel banckCardModel;
  //
  @override
  Widget build(BuildContext context) {
    return Text(
      banckCardModel.currentAmount + ' \$',
      style: TxtStyle.style(
        color: Colors.green,
        fontSize: 30.0,
      ),
    );
  }
}
