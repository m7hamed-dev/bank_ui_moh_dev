import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // consturcotr
  LocalStorage() {
    init();
  }
  // all keys
  static String firstTimeKEY = 'isFirstTime';
  // obj of shared
  static late SharedPreferences _prefs;
  // init
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    // print('isFirstTime = ${isFirstTime()}');
  }

  /// onboarding screen
  static void setFirstTime(bool value) {
    _prefs.setBool(firstTimeKEY, value);
  }

  static bool isFirstTime() {
    return _prefs.getBool(firstTimeKEY) ?? true;
  }

  /// card bank

  static void isAddCardBank(bool value) {
    _prefs.setBool('cardBankKEY', value);
  }

  static bool checkCardBank() {
    return _prefs.getBool('cardBankKEY') ?? false;
  }

  /// save card bank
  static void saveInfoCardBank(Map data) {
    _prefs.setString('idKEY', data['id']);
    _prefs.setString('wonerKEY', data['wonerName']);
    _prefs.setString('holdNameKEY', data['name']);
    _prefs.setString('expireKEY', data['expireDate']);
    _prefs.setString('currentAmountKEY', data['currentAmount']);
    _prefs.setString('cardNumberKEY', data['numberCard']);
  }

  static String getCurrentAmountFromPregs() {
    return _prefs.getString('currentAmountKEY') ?? '\$0.0';
  }

  static String getCardNumberFromPregs() {
    return _prefs.getString('cardNumberKEY') ?? '0.0';
  }

  static getInfoCardBank() {
    return _prefs.getString('wonerKEY') ?? '';
  }
}
