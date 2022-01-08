import 'package:bank_ui_moh_dev/database/local_storage.dart';
import 'package:bank_ui_moh_dev/screens/account/auth_biometric_login_view.dart';
import 'package:bank_ui_moh_dev/screens/account/register_page.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/add_card_bank_view.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/card_bank_controller.dart';
import 'package:bank_ui_moh_dev/screens/home/home_screen.dart';
import 'package:bank_ui_moh_dev/screens/transfer_money_view.dart';
import 'package:bank_ui_moh_dev/style/custom_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'screens/card_bank/bank_card_model.dart';
import 'screens/qr/scaaner_via_qr_view.dart';
import 'screens/qr/send_money_via_qr_scnner_view.dart';

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

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<List<BanckCardModel>>(
          create: (context) =>
              CardBankController().getCurrentAmountFromServer('id'),
          initialData: [
            BanckCardModel(
              currentAmount: '0.0',
              expireDate: '00/00/0000',
              id: '0',
              name: '',
              numberCard: '0000-0000-0000-0000',
              wonerName: '',
            )
          ],
        ),
        // Provider<CardBankController>(create: (_) => CardBankController()),
        // FutureProvider<CardBankController>(
        //   initialValue: BanckCardModel(
        //     currentAmount: currentAmount,
        //     expireDate: expireDate,
        //     id: id,
        //     name: name,
        //     numberCard: numberCard,
        //     wonerName: wonerName,
        //   ),
        //   create: (context) => Future.value(CardBankController()),
        // )
      ],
      child: MyApp(isFirstTime: isFirstTime),
    ),
  );
}

final _auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Banking App',
      theme: CustomTheme.themeData,
      // home: isFirstTime ? const ScreenOnBoarding() : const HomeScreen(),
      home: _auth.currentUser == null
          ? const RegistrationScreen()
          : CheckIfAddCardBank(),
      // : const HomeScreen(),
      // : const QRViewExample(),
      // : SendMoneyViaQrScnnerView(),
      // : AddCardBank(
      //     cardNumber: 'cardNumber',
      //     isAddNewCard: true,
      //   ),
      // _auth.currentUser == null ? const RegistrationScreen() : HomeScreen(),
      // : const SendMoneyViaQrScnnerView(),
      // :  const TransferMoney(currentBalance: 2000.0),
      // : const AuthBiometricLoginView(),
      builder: EasyLoading.init(),
      // : const HomeScreen(),
    );
  }
}

class CheckIfAddCardBank extends StatefulWidget {
  const CheckIfAddCardBank({Key? key}) : super(key: key);

  @override
  State<CheckIfAddCardBank> createState() => _CheckIfAddCardBankState();
}

class _CheckIfAddCardBankState extends State<CheckIfAddCardBank> {
  bool _isAddCardBank = false;
  void _check() {
    _isAddCardBank = LocalStorage.checkCardBank();
    if (!mounted) {
      return;
    }
    setState(() {});
    print('_isAddCardBank = $_isAddCardBank');
  }

  @override
  void initState() {
    super.initState();
    _check();
  }

  //
  @override
  Widget build(BuildContext context) {
    return _isAddCardBank ? const TestSendBalance() : const AddCardBank();
  }
}
