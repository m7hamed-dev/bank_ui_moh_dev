import 'dart:math';

import 'package:bank_ui_moh_dev/components/customeDialog/customeDialog.dart';
import 'package:bank_ui_moh_dev/components/textfield/customeTextField.dart';
import 'package:bank_ui_moh_dev/database/databaseHelper.dart';
import 'package:bank_ui_moh_dev/database/local_storage.dart';
import 'package:bank_ui_moh_dev/model/userData.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class AddCardDetails extends StatefulWidget {
  const AddCardDetails({Key? key}) : super(key: key);

  @override
  _AddCardDetailsState createState() => _AddCardDetailsState();
}

class _AddCardDetailsState extends State<AddCardDetails> {
  String cardHolderName = '';
  String cardNumber = '';
  String cardExpiry = '';
  double currentBalance = 0.0;

  final DatabaseHelper _dbhelper = DatabaseHelper();
  int _lastID = 0;
  void _getLastID() {
    if (!mounted) {
      return;
    }
    _lastID = LocalStorage.getLastCardID() + 1;
    if (_lastID == 1) {
      _lastID++;
      setState(() {});
    }
    debugPrint('_lastID = $_lastID');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getLastID();
  }

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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          // if (cardHolderName.isEmpty &&
                          //     cardNumber.isEmpty &&
                          //     cardExpiry.isEmpty &&
                          //     currentBalance == 0.0) {
                          //
                          UserData _userData = UserData(
                            id: _lastID,
                            userName: cardHolderName,
                            cardNumber: cardNumber,
                            cardExpiry: cardExpiry,
                            totalAmount: currentBalance,
                          );
                          await _dbhelper.insertUserDetails(_userData);
                          LocalStorage.setNewCardID(_lastID);

                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  onPressed: () {
                                    Push.toPage(context, const HomeScreen());
                                  },
                                  title: "Success",
                                  isSuccess: true,
                                  description:
                                      "Thanking for adding your details",
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
