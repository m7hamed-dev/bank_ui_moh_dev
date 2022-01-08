import 'package:bank_ui_moh_dev/api/firebase_methods.dart';
import 'package:bank_ui_moh_dev/components/textfield/input.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/bank_card_model.dart';
import 'package:bank_ui_moh_dev/tools/random_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/src/provider.dart';

import 'card_bank_widget.dart';

class CardBankController extends FireBaseMethods {
  //
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //
  @override
  Future create(Map<String, dynamic> data) async {
    await _fireStore
        .collection(Constant.cardBankCollection)
        .doc(RandomID.getRandom)
        .set(data);
  }

  @override
  Future delete(String id) async {
    await _fireStore.collection(Constant.cardBankCollection).doc(id).delete();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getALL() {
    return _fireStore.collection(Constant.cardBankCollection).snapshots();
  }

  @override
  Future<QuerySnapshot> getOne(String id) async {
    return _fireStore
        .collection(Constant.cardBankCollection)
        .where('number', isEqualTo: id)
        .get();
  }

  Stream<List<BanckCardModel>> getCurrentAmountFromServer(String id) {
    return _fireStore
        .collection(Constant.cardBankCollection)
        // .doc('${Constant.cardBankCollection}/$id')
        // .where('numberCard', isEqualTo: id)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((document) {
        return BanckCardModel.fromJson(document.data());
      }).toList();
    });
  }

  Future<void> sendBalance(BanckCardModel card, String amount) async {
    double _newAmount = double.parse(card.currentAmount) - 1000;
    // + double.parse(amount);
    var _data = {
      'id': card.id,
      'name': card.name,
      'numberCard': card.numberCard,
      'expireDate': card.expireDate,
      'currentAmount': '$_newAmount',
      'wonerName': card.wonerName
    };
    await _fireStore
        .collection(Constant.cardBankCollection)
        .doc(card.id)
        .update(_data)
        .then((value) {
      EasyLoading.showSuccess('success !!');
    }).catchError((onError) {
      print('onErrr $onError');
    });

    // await _fireStore.collection(Constant.cardBankCollection).doc(id).set(_data);
  }

  @override
  Future update(String id, Map<String, dynamic> data) async {
    await _fireStore.collection(Constant.cardBankCollection).doc(id).set(data);
  }
}

class TestSendBalance extends StatefulWidget {
  const TestSendBalance({Key? key}) : super(key: key);

  @override
  State<TestSendBalance> createState() => _TestSendBalanceState();
}

class _TestSendBalanceState extends State<TestSendBalance> {
  bool isSearch = false;
  List<BanckCardModel> cards = [];
  BanckCardModel cardModel = BanckCardModel(
    currentAmount: '',
    expireDate: '',
    id: '',
    name: '',
    numberCard: '',
    wonerName: '',
  );
  //
  void _onChange(String value, List<BanckCardModel> list) {
    if (value.isNotEmpty) {
      cards = value.isEmpty
          ? list
          : list.where((BanckCardModel card) {
              if (value == card.numberCard) {
                _id = card.id;
                print('_id = $_id');
                return true;
              }
              return false;
            }).toList();
      //
      setState(() {});
    }
  }

  String _id = '';
  //
  @override
  Widget build(BuildContext context) {
    final _cardStream = context.read<List<BanckCardModel>>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Input(
              hintName: 'hintName',
              onChanged: (val) {
                _onChange(val, _cardStream);
              },
              keyboardTypeNumber: false,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  cardModel = cards[index];
                  return Column(
                    children: [
                      CardBankWidget(card: cards[index]),
                      Center(
                        child: IconButton(
                          onPressed: () async {
                            await CardBankController().sendBalance(
                              // _id,
                              // BanckCardModel(
                              //   currentAmount: '0.89',
                              //   expireDate: '2020/12/12',
                              //   id: '7981efe0-6fc2-11ec-a7c9-4d9ee3f638dd',
                              //   name: 'new bank om',
                              //   numberCard: '5555',
                              //   wonerName: 'new omda',
                              // ),
                              cards[index],
                              '11',
                            );
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ],
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
