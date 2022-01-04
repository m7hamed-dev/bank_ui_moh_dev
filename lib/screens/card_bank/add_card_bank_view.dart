import 'package:bank_ui_moh_dev/components/customeDialog/customeDialog.dart';
import 'package:bank_ui_moh_dev/components/textfield/customeTextField.dart';
import 'package:bank_ui_moh_dev/database/databaseHelper.dart';
import 'package:bank_ui_moh_dev/database/local_storage.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/add_card_bank_controller.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';

class AddCardBank extends StatefulWidget {
  const AddCardBank({Key? key}) : super(key: key);

  @override
  _AddCardBankState createState() => _AddCardBankState();
}

class _AddCardBankState extends State<AddCardBank> {
  String cardHolderName = '';
  String cardNumber = '';
  String cardExpiry = '';
  double currentBalance = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Account Details"),
        centerTitle: true,
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
              hintName: "Enter card number",
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
              onChanged: (value) => {currentBalance = double.parse(value)},
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
                  CardBankController().create(map);

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
