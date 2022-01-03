import 'package:bank_ui_moh_dev/components/customeDialog/customeDialog.dart';
import 'package:bank_ui_moh_dev/components/textfield/customeTextField.dart';
import 'package:bank_ui_moh_dev/database/databaseHelper.dart';
import 'package:bank_ui_moh_dev/model/userData.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

class AddCardDetails extends StatefulWidget {
  @override
  _AddCardDetailsState createState() => _AddCardDetailsState();
}

class _AddCardDetailsState extends State<AddCardDetails> {
  late String cardHolderName;
  late String cardNumber;
  late String cardExpiry;
  late double currentBalance;

  DatabaseHelper _dbhelper = DatabaseHelper();

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
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
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
                      onChanged: (value) =>
                          {currentBalance = double.parse(value)},
                      keyboardTypeNumber: true,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (cardHolderName != null &&
                              cardNumber != null &&
                              cardExpiry != null &&
                              currentBalance != null) {
                            UserData _userData = UserData(
                              id: 1,
                              userName: cardHolderName,
                              cardNumber: cardNumber,
                              cardExpiry: cardExpiry,
                              totalAmount: currentBalance,
                            );

                            await _dbhelper.insertUserDetails(_userData);

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    onPressed: () {
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()))
                                          .then((value) => {});
                                    },
                                    title: "Success",
                                    isSuccess: true,
                                    description:
                                        "Thanking for adding your details",
                                    buttonText: "Ok",
                                    addIcon: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  );
                                });
                          } else {
                            print("Fail to insert");
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
