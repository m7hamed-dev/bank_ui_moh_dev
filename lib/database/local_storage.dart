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
  static void setNewCardID(int value) {
    _prefs.setInt('CardIDKEY', value);
  }

  static int getLastCardID() {
    return _prefs.getInt('CardIDKEY') ?? 1;
  }
}
