import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/database/databaseHelper.dart';
import 'package:bank_ui_moh_dev/screens/users/users_view.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                height: 100,
                child: UsersView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
