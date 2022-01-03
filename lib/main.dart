import 'package:bank_ui_moh_dev/database/local_storage.dart';
import 'package:bank_ui_moh_dev/screens/screen_onboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  await LocalStorage.init();
  var boolKey = 'isFirstTime';
  // var isFirstTime = prefs.getBool(boolKey) ?? true;
  bool isFirstTime = LocalStorage.isFirstTime();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);
  final bool isFirstTime;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Banking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isFirstTime
          ? const ScreenOnBoarding()
          : const HomeScreen(),
    );
  }
}
