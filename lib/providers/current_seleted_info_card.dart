import 'package:bank_ui_moh_dev/model/userData.dart';
import 'package:flutter/material.dart';

class CurrentSeletedInfoCardProvider with ChangeNotifier {
  late UserData userData = UserData(
    id: 1,
    cardNumber: '',
    cardExpiry: '',
    userName: '',
    totalAmount: 0.0,
  );
  //
  void seletedUser(UserData user) {
    userData = user;
    notifyListeners();
  }
}
