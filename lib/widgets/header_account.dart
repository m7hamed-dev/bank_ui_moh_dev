import 'package:bank_ui_moh_dev/providers/current_seleted_info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderAccount extends StatelessWidget {
  const HeaderAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      padding: const EdgeInsets.all(10.0),
      color: Colors.green,
      child: Consumer<CurrentSeletedInfoCardProvider>(
        builder: (context, value, child) {
          return Row(
            children: [
              
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.blue.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(value.userData.userName),
                ),
              ),
              const Spacer(),
              Text('\$ ${value.userData.totalAmount}'),
            ],
          );
        },
      ),
    );
  }
}
