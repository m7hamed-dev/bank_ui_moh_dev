import 'dart:math';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/card_bank_controller.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/delay_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<QuerySnapshot>(
          future: CardBankController().getOne('4331f9d0-6fc2-11ec-a7a5-91553aced1ef'),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'loading',
                style: TxtStyle.style(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  snapshot.data!.docs[index]['name'],
                  style: TxtStyle.style(),
                );
              },
            );
          },
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HistoryView',
          style: TxtStyle.style(fontSize: Constant.fontSizeAppBar),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(20, (index) {
                return DelayAnimation(
                  duration: Duration(milliseconds: 500 + index * 10),
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: _leading(),
                      title: Text(
                        'HistoryView $index',
                        style: TxtStyle.style(
                          fontSize: 15.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      subtitle: Text(
                        '6 Jun 2022',
                        style: TxtStyle.style(
                          fontSize: 11.0,
                        ),
                      ),
                      trailing: Icon(
                        index.isEven
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: index.isEven ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Container _leading() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
