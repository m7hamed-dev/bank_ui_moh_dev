import 'package:bank_ui_moh_dev/api/firebase_methods.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/database/local_storage.dart';
import 'package:bank_ui_moh_dev/screens/account/profile_view.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/bank_card_model.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/card_bank_controller.dart';
import 'package:bank_ui_moh_dev/screens/home/widgets/card_current_balance.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/delay_animation.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/tools/random_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../history/history_view.dart';
import 'home_content_view.dart';
import '../notification/notification_view.dart';
import '../qr/send_money_via_qr_scnner_view.dart';

class TesthistoryCollection extends FireBaseMethods {
  final _fireStore = FirebaseFirestore.instance;
  String id = '1';
  @override
  Future create(Map<String, dynamic> data) async {
    _fireStore
        .collection('historyCollection')
        .doc('0')
        // .doc(RandomID.getRandom)
        .set(data);
  }

  @override
  Future delete(String id) async {
    _fireStore.collection('historyCollection').doc('1').delete();
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
}

///
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;
  List datas = ["Money Transfer", "Bank Withdraw", "Insights Tracking"];
  final List pagesName = <String>[
    'home',
    'trans',
    'notifications',
    'profile',
  ];
  final List iconsName = <IconData>[
    Icons.home,
    Icons.transform,
    Icons.notifications,
    Icons.verified_user,
  ];

  int _selectedPageIndex = 0;
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PageView.builder(
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (context, index) => _pages[_selectedPageIndex],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        // TesthistoryCollection().delete('id');
        TesthistoryCollection().create({
          'name': 'mohamed',
          'no': RandomID.getRandom,
        });
      }),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        height: 60.0,
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.03),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            4,
            (index) => GestureDetector(
              onTap: () => onTap(index),
              child: DelayAnimation(
                duration: const Duration(milliseconds: 1400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      iconsName[index],
                      color: getColor(index),
                    ),
                    Text(
                      pagesName[index],
                      style: TxtStyle.style(
                        color: getColor(index),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.linear,
                      height: 3,
                      width: widthUnderLine(index),
                      color: getColor(index),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPageChanged(int value) {
    _selectedPageIndex = value;
    setState(() {});
  }

  Future<void> onTap(int index) async {
    _selectedPageIndex = index;
    getColor(index);
    widthUnderLine(index);
    setState(() {});
  }

  Color getColor(int index) {
    if (_selectedPageIndex == index) {
      return Colors.black;
    }
    return Colors.grey;
  }

  double widthUnderLine(int index) {
    if (_selectedPageIndex == index) {
      return 20.0;
    }
    return 5.0;
  }

  final List<Widget> _pages = const [
    HomeContentView(),
    NotificationView(),
    ProfileView(),
    ProfileView()
  ];
}

class CurrentAmount extends StatefulWidget {
  const CurrentAmount({Key? key}) : super(key: key);

  @override
  State<CurrentAmount> createState() => _CurrentAmountState();
}

class _CurrentAmountState extends State<CurrentAmount> {
  // String _currentAmount = '';
  String _cardNumber = '';
  void _getCardNumber() {
    if (!mounted) {
      return;
    }
    _cardNumber = LocalStorage.getCardNumberFromPregs();
    // _cardNumber = '7981efe0-6fc2-11ec-a7c9-4d9ee3f638dd';
    print('_cardNumber = $_cardNumber');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getCardNumber();
  }

  @override
  Widget build(BuildContext context) {
    final _cardStream = context.read<List<BanckCardModel>>();
    return Column(
      children: [
        Text(
          'Current Balance',
          style: TxtStyle.style(color: Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardCurrentBalance(banckCardModel: _cardStream[0]),
            const SizedBox(width: 10.0),
            InkWell(
              child: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.grey.shade400,
              ),
            )
          ],
        ),
        Divider(
          thickness: 1.0,
          endIndent: 20.0,
          indent: 20.0,
          color: Colors.black.withOpacity(.07),
        ),
        //
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Push.toPageWithAnimation(
                    context, const SendMoneyViaQrScnnerView());
              },
              child: Column(
                children: const [
                  Icon(Icons.qr_code_2_rounded),
                  SizedBox(height: 10.0),
                  Text('QR'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Push.toPageWithAnimation(
                    context, const SendMoneyViaQrScnnerView());
              },
              child: Column(
                children: const [
                  Icon(Icons.send),
                  SizedBox(height: 10.0),
                  Text('Send'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Push.toPageWithAnimation(context, const HistoryView());
              },
              child: Column(
                children: const [
                  Icon(Icons.history),
                  SizedBox(height: 10.0),
                  Text('History'),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class GetUserName extends StatelessWidget {
  const GetUserName({
    Key? key,
    required this.userName,
  }) : super(key: key);

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Text(userName,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: mgBlackColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ));
  }
}
