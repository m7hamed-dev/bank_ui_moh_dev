import 'package:bank_ui_moh_dev/api/firebase_methods.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardBankController extends FireBaseMethods {
  //
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  ///
  @override
  Future create(Map<String, dynamic> data) async {
    await _fireStore.collection(Constant.cardBankCollection).add(data);
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
  Future getOne(String id) {
    throw UnimplementedError();
  }

  @override
  Future update(String id, Map<String, dynamic> data) async {
    await _fireStore.collection(Constant.cardBankCollection).doc(id).set(data);
  }
}
