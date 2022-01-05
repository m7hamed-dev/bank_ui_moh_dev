import 'package:bank_ui_moh_dev/database/local_storage.dart';
import 'package:bank_ui_moh_dev/screens/account/register_page.dart';
import 'package:bank_ui_moh_dev/screens/screen_onboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/current_seleted_info_card.dart';
import 'screens/card_bank/add_card_bank_view.dart';
import 'screens/crud/crud.dart';
import 'screens/home_screen.dart';
import 'screens/transfer_money.dart';

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

final _auth = FirebaseAuth.instance;

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
      home: _auth.currentUser == null
          ? const RegistrationScreen()
          : const TransferMoney(
              currentBalance: 100,
              currentCustomerId: 1,
              currentUserCardNumebr: 'currentUserCardNumebr',
              senderName: 'mohmaed',
            ),
      // : const ChatScreen(),
    );
  }
}
