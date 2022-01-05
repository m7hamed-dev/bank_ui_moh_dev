import 'package:bank_ui_moh_dev/screens/account/bio_metric_view.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/widgets/btn.dart';
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
  String _value = '\$';
  //
  void onNumberClick(int number) {
    if (_value == '0.0') {
      _value = '';
      setState(() {});
    }
    _value += '$number';
    setState(() {});
  }

  void onIconClearClick() {
    if (_value.isNotEmpty) {
      // ['a', 'a', 'a', 'b', 'c', 'd']
      List<String> c = _value.split('');
      // ['a', 'a', 'a', 'b', 'c']
      c.removeLast();
      _value = c.join();
      setState(() {});
    } else {
      _value = '0.0';
      setState(() {});
    }
  }

  void _clearValue() {
    _value = '0.0';
    setState(() {});
  }

  bool _isConfirm = false;
  void cofirmBtnClick() {
    _isConfirm = !_isConfirm;
    setState(() {});
    if (_isConfirm) {
      Push.toPageWithAnimation(context, const BioMetricView());
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                ),
                const SizedBox(height: 40.0),
                Text(
                  "Current Balance",
                  style: TxtStyle.style(fontSize: 14.0, color: Colors.grey),
                ),
                Text(
                  '\$ 2000.0',
                  style: TxtStyle.style(fontSize: 30.0, color: Colors.green),
                ),
                const SizedBox(height: 40.0),
                Center(
                  child: Text(
                    _value,
                    style: TxtStyle.style(fontSize: 30.0),
                  ),
                ),
                // TextFormField(
                //   textAlign: TextAlign.center,
                //   keyboardType: TextInputType.number,
                //   style: TxtStyle.style(fontSize: 40.0),
                //   decoration: InputDecoration(
                //     hintText: '\$0.0',
                //     hintStyle: TxtStyle.style(
                //       fontSize: 40.0,
                //       color: Colors.grey,
                //     ),
                //     labelStyle: TxtStyle.style(
                //       fontSize: 40.0,
                //       color: Colors.grey,
                //     ),
                //     border: InputBorder.none,
                //     focusedBorder: InputBorder.none,
                //     errorBorder: InputBorder.none,
                //   ),
                // ),

                const SizedBox(height: 40.0),
                _numbers(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyButton(
          color: _isConfirm ? Colors.green : Colors.grey,
          title: _isConfirm ? 'confirmed' : 'confirm',
          onPressed: cofirmBtnClick,
        ),
      ),
    );
  }

  GridView _numbers() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 4 / 2,
      ),
      itemCount: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        // clear last number
        if (index == 10) {
          return InkWell(
            onTap: onIconClearClick,
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.grey,
            ),
          );
        }
        // clear all
        if (index == 11) {
          return InkWell(
            onTap: _clearValue,
            child: const Icon(
              Icons.clear,
              color: Colors.red,
            ),
          );
        }
        return InkWell(
          onTap: () => onNumberClick(index),
          child: Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            // color: Colors.blue,
            child: Text(
              '$index',
              style: TxtStyle.style(fontSize: 30.0),
            ),
          ),
        );
      },
    );
  }
}
