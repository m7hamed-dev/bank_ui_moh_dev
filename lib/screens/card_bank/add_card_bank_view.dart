import 'package:bank_ui_moh_dev/components/customeDialog/customeDialog.dart';
import 'package:bank_ui_moh_dev/components/textfield/customeTextField.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/card_bank_controller.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';

class AddCardBank extends StatefulWidget {
  final String cardNumber;
  final bool isAddNewCard;

  const AddCardBank({
    Key? key,
    required this.cardNumber,
    required this.isAddNewCard,
  }) : super(key: key);
  //
  @override
  _AddCardBankState createState() => _AddCardBankState();
}

class _AddCardBankState extends State<AddCardBank> {
  String cardHolderName = '';
  String cardNumber = '';
  String cardExpiry = '';
  String currentBalance = '';
  // double currentBalance = 0.0;

  @override
  Widget build(BuildContext context) {
    if (widget.isAddNewCard) {
      print('widget.cardNumber= ${widget.cardNumber}');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Account Details"),
        centerTitle: true,
        actions: [
          widget.isAddNewCard
              ? const SizedBox()
              : IconButton(
                  onPressed: () async {
                    try {
                      print('widget.cardNumber = ${widget.cardNumber}');
                      await CardBankController().delete(widget.cardNumber);
                    } catch (e) {
                      print('ex $e');
                    }
                    // Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete),
                )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            CustomTextField(
              hintName: "Enter cardholder name",
              onChanged: (value) => {cardHolderName = value},
              keyboardTypeNumber: false,
            ),
            CustomTextField(
              hintName:
                  widget.isAddNewCard ? 'Enter card number' : widget.cardNumber,
              onChanged: (value) => {cardNumber = value},
              keyboardTypeNumber: false,
            ),
            CustomTextField(
              hintName: "Enter card expiry date",
              onChanged: (value) => {cardExpiry = value},
              keyboardTypeNumber: false,
            ),
            CustomTextField(
              hintName: "Enter current amount",
              onChanged: (value) => {currentBalance = value},
              keyboardTypeNumber: true,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> map = {
                    'name': cardHolderName,
                    'number': cardNumber,
                    'expireDate': cardExpiry,
                    'amount': currentBalance
                  };
                  if (widget.isAddNewCard) {
                    print('create');
                    await CardBankController().create(map);
                  } else {
                    print('update');
                    await CardBankController().update(widget.cardNumber, map);
                  }
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
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
