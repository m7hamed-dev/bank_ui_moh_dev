import 'package:bank_ui_moh_dev/database/local_storage.dart';
import 'package:bank_ui_moh_dev/screens/screen_onboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/current_seleted_info_card.dart';
import 'screens/crud/crud.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Firebase has not been correctly initialized.
  await LocalStorage.init();
  bool isFirstTime = LocalStorage.isFirstTime();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CurrentSeletedInfoCardProvider()),
    ],
    child: MyApp(isFirstTime: isFirstTime),
  ));
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
      // home: isFirstTime ? const ScreenOnBoarding() : const HomeScreen(),
      home: CrudPage(),
    );
  }
}
