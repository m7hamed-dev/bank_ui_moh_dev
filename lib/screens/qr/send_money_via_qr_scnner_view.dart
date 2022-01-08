import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/card_bank_controller.dart';
import 'package:bank_ui_moh_dev/screens/qr/send_money_controller.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/delay_animation.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/widgets/my_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'scaaner_via_qr_view.dart';

class SendMoneyViaQrScnnerView extends StatefulWidget {
  const SendMoneyViaQrScnnerView({Key? key}) : super(key: key);

  @override
  State<SendMoneyViaQrScnnerView> createState() =>
      _SendMoneyViaQrScnnerViewState();
}

class _SendMoneyViaQrScnnerViewState extends State<SendMoneyViaQrScnnerView> {
  bool _isClickScan = false;
  bool _isClickCardID = false;
  double _heightCardID = 0.0;
  //

  void onClickCardBacnID() {
    _isClickCardID = !_isClickCardID;
    if (_isClickCardID) {
      _titleCardBankID = 'Hide';
      _heightCardID = 400.0;
      setState(() {});
    } else {
      _titleCardBankID = 'By Card No';
      _heightCardID = 0.0;
      setState(() {});
    }
  }

  String _titleCardBankID = 'By Card No';
  double value = 0.0;
  Future<void> _dialog(BuildContext context, String title, String value) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextFormField(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send TO', style: TxtStyle.style()),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 40.0),
          InkWell(
            onTap: () {
              final Map<String, dynamic> data = {
                'amount':'300',
              };
              SendMoneyController().create(data);
            },
            child: Icon(Icons.send),
          ),
          const SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _methdSender(_titleCardBankID, Icons.credit_card),
              //
              _methdSender(
                'Scan',
                Icons.qr_code_scanner_outlined,
                isClicQrCard: true,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        height: _heightCardID,
        duration: const Duration(
          milliseconds: 600,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3.0,
              color: Colors.black.withOpacity(.2),
              spreadRadius: 5.0,
              offset: const Offset(0.0, 2.0),
            )
          ],
        ),
        child: ListView(
          children: [
            InkWell(
              onTap: onClickCardBacnID,
              child: Center(
                child: Container(
                  height: 10.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.3),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            InkWell(
              onTap: () async {
                // _dialog(context, 'id', '100.0');
                await CardBankController().getOne('0929469s784').then((value) {
                  // print(value);
                  // return;
                  Push.toPageWithAnimation(
                    context,
                    ReciverInfoView(
                      code: value,
                    ),
                  );
                });
              },
              child: Text(
                'Card NO',
                style: TxtStyle.style(fontSize: 30.0),
              ),
            ),
            MyBtn(),
          ].map((e) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: DelayAnimation(
                child: e,
                duration: const Duration(milliseconds: 2000),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Column _methdSender(String title, IconData icon, {bool? isClicQrCard}) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (isClicQrCard == true) {
              Push.toPageWithAnimation(
                context,
                const ScaanerViaQrView(),
                // const ReciverInfoView(),
                alignment: Alignment.center,
              );
            } else {
              onClickCardBacnID();
            }
          },
          splashColor: Colors.pink,
          hoverColor: Colors.pink,
          customBorder: const CircleBorder(),
          child: PhysicalModel(
            color: Colors.black.withOpacity(.6),
            shape: BoxShape.circle,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                icon,
                size: 40.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          title,
          style: TxtStyle.style(),
        ),
      ],
    );
  }
}

class ReciverInfoView extends StatelessWidget {
  const ReciverInfoView({Key? key, required this.code}) : super(key: key);
  final QuerySnapshot code;
  // final QuerySnapshot code;
  @override
  Widget build(BuildContext context) {
    if (code.docs.isEmpty) {
      return Text(
        'isEmpty',
        style: TxtStyle.style(fontSize: 90.0),
      );
    }
    return ListView.builder(
      itemCount: code.docs.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(
          code.docs[index]['name'],
          style: TxtStyle.style(),
        );
      },
    );
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text(
    //         'ReciverInfoView : Mohamed',
    //         style: TxtStyle.style(
    //           fontSize: Constant.fontSizeAppBar,
    //         ),
    //       ),
    //     ),
    //     body: Center(
    //       child: FutureBuilder<QuerySnapshot>(
    //         future: CardBankController().getOne(code),
    //         builder:
    //             (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //           if (!snapshot.hasData) {
    //             return Text(
    //               'loading',
    //               style: TxtStyle.style(),
    //             );
    //           }
    //           return ListView.builder(
    //             itemCount: snapshot.data!.docs.length,
    //             itemBuilder: (BuildContext context, int index) {
    //               return Text(
    //                 snapshot.data!.docs[index]['name'],
    //                 style: TxtStyle.style(),
    //               );
    //             },
    //           );
    //         },
    //       ),
    //     )
    //     // body: ListView(
    //     //   children: [
    //     //     Text(
    //     //       'Send To',
    //     //       style: TxtStyle.style(),
    //     //     ),
    //     //     Text(
    //     //       date[0]['number'],
    //     //       style: TxtStyle.style(),
    //     //     ),
    //     //     // Text(
    //     //     //   date['name'],
    //     //     //   style: TxtStyle.style(),
    //     //     // ),
    //     //     ListTile(
    //     //       leading: const CircleAvatar(),
    //     //       title: Text(
    //     //         'mohamed syed sulima',
    //     //         style: TxtStyle.style(),
    //     //       ),
    //     //       subtitle: Text(
    //     //         'moh94syed@gmai.com',
    //     //         style: TxtStyle.style(color: Colors.grey),
    //     //       ),
    //     //     ),
    //     //     Divider(
    //     //       thickness: 10.0,
    //     //       endIndent: 20.0,
    //     //       indent: 20.0,
    //     //       color: Colors.black.withOpacity(.07),
    //     //     ),
    //     //     Center(
    //     //       child: Text(
    //     //         'Amount \$ 1020.0',
    //     //         style: TxtStyle.style(
    //     //           color: Colors.green,
    //     //           fontSize: 20.0,
    //     //         ),
    //     //       ),
    //     //     ),
    //     //     Divider(
    //     //       thickness: 10.0,
    //     //       endIndent: 20.0,
    //     //       indent: 20.0,
    //     //       color: Colors.black.withOpacity(.07),
    //     //     ),
    //     //     Text(
    //     //       'Note',
    //     //       style: TxtStyle.style(),
    //     //     ),
    //     //   ].map((e) {
    //     //     return Padding(
    //     //       padding: const EdgeInsets.all(10.0),
    //     //       child: DelayAnimation(
    //     //         child: e,
    //     //         duration: const Duration(milliseconds: 400),
    //     //       ),
    //     //     );
    //     //   }).toList(),
    //     // ),

    //     );
  }
}
