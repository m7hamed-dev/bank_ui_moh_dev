import 'package:bank_ui_moh_dev/api/firebase_methods.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/tools/random_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendMoneyController extends FireBaseMethods {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //
  @override
  Future create(Map<String, dynamic> data) async {
    await _fireStore
        .collection(Constant.sendMoneyCollection)
        .doc(RandomID.getRandom)
        .set(data)
        .then((value) {
      var newAmount = data['currentAmount'] + data['amount'];
      debugPrint('newAmount = $newAmount');
      update(RandomID.getRandom, newAmount);
    });
  }

  Future sendMoney(
    Map<String, dynamic> data,
    senderID,
  ) async {
    await _fireStore
        .collection(Constant.sendMoneyCollection)
        .doc(RandomID.getRandom)
        .set(data)
        .then((value) {
      var newAmount = data['currentAmount'] + data['amount'];
      debugPrint('newAmount = $newAmount');
      update(RandomID.getRandom, newAmount);
    });
  }

  @override
  Future delete(String id) async {
    await _fireStore.collection(Constant.sendMoneyCollection).doc(id).delete();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getALL() {
    return _fireStore.collection(Constant.sendMoneyCollection).snapshots();
  }

  @override
  Future getOne(String id) {
    throw UnimplementedError();
  }

  @override
  Future update(String id, Map<String, dynamic> data) async {
    await _fireStore.collection(Constant.sendMoneyCollection).doc(id).set(data);
  }
}
