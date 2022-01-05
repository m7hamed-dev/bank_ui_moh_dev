import 'package:bank_ui_moh_dev/api/firebase_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends FireBaseMethods {
  final _auth = FirebaseAuth.instance;
  @override
  Future create(Map<String, dynamic> data) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  getALL() {
    // TODO: implement getALL
    throw UnimplementedError();
  }

  @override
  getOne(String id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future update(String id, Map<String, dynamic> data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
