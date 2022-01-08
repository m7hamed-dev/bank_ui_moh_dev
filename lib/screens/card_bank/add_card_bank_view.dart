import 'package:bank_ui_moh_dev/components/customeDialog/customeDialog.dart';
import 'package:bank_ui_moh_dev/components/textfield/input.dart';
import 'package:bank_ui_moh_dev/database/local_storage.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/card_bank_controller.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/tools/random_id.dart';
import 'package:bank_ui_moh_dev/widgets/my_btn.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../home/home_screen.dart';

class AddCardBank extends StatefulWidget {
  const AddCardBank({
    Key? key,
  }) : super(key: key);
  //
  @override
  _AddCardBankState createState() => _AddCardBankState();
}

class _AddCardBankState extends State<AddCardBank> {
  String wonerName = '';
  String cardHolderName = '';
  String cardNumber = '';
  String cardExpiry = '';
  String currentBalance = '';
  // double currentBalance = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Account Details"),
        centerTitle: true,
        // actions: [
        //   widget.isAddNewCard
        //       ? const SizedBox()
        //       : IconButton(
        //           onPressed: () async {
        //             try {
        //               print('widget.cardNumber = ${widget.cardNumber}');
        //               await CardBankController().delete(widget.cardNumber);
        //             } catch (e) {
        //               print('ex $e');
        //             }
        //             // Navigator.pop(context);
        //           },
        //           icon: const Icon(Icons.delete),
        //         )
        // ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ListView(
          children: [
            cardNumber.isNotEmpty
                ? QrImage(
                    data: cardNumber,
                    version: QrVersions.auto,
                    size: 100.0,
                  )
                : const SizedBox(),
            Input(
              hintName: "Enter wonerName",
              onChanged: (value) => wonerName = value,
              keyboardTypeNumber: false,
            ),
            Input(
              hintName: "Enter cardholder name",
              onChanged: (value) => {cardHolderName = value},
              keyboardTypeNumber: false,
            ),
            Input(
              hintName: 'Enter card number',
              onChanged: (value) {
                cardNumber = value;
                setState(() {});
              },
              keyboardTypeNumber: false,
            ),
            Input(
              hintName: "Enter card expiry date",
              onChanged: (value) => {cardExpiry = value},
              keyboardTypeNumber: false,
            ),
            Input(
              hintName: "Enter current amount",
              onChanged: (value) => {currentBalance = value},
              keyboardTypeNumber: true,
            ),
            MyBtn(
              onPressed: () async {
                Map<String, dynamic> map = {
                  'id': RandomID.getRandom,
                  'name': cardHolderName,
                  'numberCard': cardNumber,
                  'expireDate': cardExpiry,
                  'currentAmount': currentBalance,
                  'wonerName': wonerName
                };
                await CardBankController().create(map);
                LocalStorage.isAddCardBank(true);
                LocalStorage.saveInfoCardBank(map);
                // else {
                //   debugPrint('update');
                //   await CardBankController().update(widget.cardNumber, map);
                // }
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                        onPressed: () {
                          Push.toPage(context, const HomeScreen());
                        },
                        title: "Success",
                        isSuccess: true,
                        description: "Thanking for adding your details",
                        buttonText: "Ok",
                        addIcon: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 50,
                        ),
                      );
                    });
                // }
              },
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ].map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
