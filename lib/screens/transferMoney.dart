import 'package:bank_ui_moh_dev/components/customerList/customerList.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/database/databaseHelper.dart';
import 'package:bank_ui_moh_dev/model/userData.dart';
import 'package:flutter/material.dart';

import 'payment.dart';

class TransferMoney extends StatefulWidget {
  final double currentBalance;
  final int currentCustomerId;
  final String currentUserCardNumebr, senderName;

  const TransferMoney({
    Key? key,
    required this.currentBalance,
    required this.currentCustomerId,
    required this.currentUserCardNumebr,
    required this.senderName,
  }) : super(key: key);

  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  double _currentBalance = 0.0;
  DatabaseHelper _dbHelper = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer Money"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: mgDefaultPadding),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      "Current Balance",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                   const SizedBox(height: 10),
                    Text(
                      _currentBalance == widget.currentBalance
                          ? "₹ 0"
                          : "₹ ${widget.currentBalance}",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: _currentBalance == widget.currentBalance
                                ? Colors.red
                                : Colors.green,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: FutureBuilder<List<UserData>>(
                future: _dbHelper.getUserDetailsList(widget.currentCustomerId),
                builder: (context, snapshot) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: mgDefaultPadding),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Payment(
                              customerAvatar: snapshot.data![index].userName[0],
                              customerName: snapshot.data![index].userName,
                              senderName: widget.senderName,
                              customerAccountNumber:
                                  snapshot.data![index].cardNumber,
                              currentUserCardNumber:
                                  widget.currentUserCardNumebr,
                              currentCustomerId: widget.currentCustomerId,
                              currentUserBalance: widget.currentBalance,
                              transferTouserId: snapshot.data![index].id,
                              tranferTouserCurrentBalance:
                                  snapshot.data![index].totalAmount,
                            ),
                          ),
                        ),
                        child: CustomerList(
                          transactionDate: '2021  -moh',
                          customerName: snapshot.data![index].userName,
                          currentBalance: snapshot.data![index].totalAmount,
                          avatar: snapshot.data![index].userName[0],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ₹
