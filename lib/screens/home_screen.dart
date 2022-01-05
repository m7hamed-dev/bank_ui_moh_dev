import 'package:bank_ui_moh_dev/components/operationCard/operation_card.dart';
import 'package:bank_ui_moh_dev/components/transactionHistory/transactionHistory.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/database/databaseHelper.dart';
import 'package:bank_ui_moh_dev/model/transectionDetails.dart';
import 'package:bank_ui_moh_dev/screens/account/profile_view.dart';
import 'package:bank_ui_moh_dev/screens/home/listview_atm_card.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/widgets/btn.dart';
import 'package:bank_ui_moh_dev/widgets/header_account.dart';
import 'package:flutter/material.dart';
import 'card_bank/add_card_bank_view.dart';
import 'operation/operation_view.dart';
import 'users/users_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _dbhelper = DatabaseHelper();
  DateTime currentTime = DateTime.now();
  List<String> greetingList = [
    "Good Morning",
    "Good AfterNoon",
    "Good Evening",
    "Good Night"
  ];
  String greeting = '';

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

  void getGreeting() {
    if (currentTime.hour < 12) {
      greeting = greetingList[0];
    } else if (currentTime.hour >= 12 && currentTime.hour < 18) {
      greeting = greetingList[1];
    } else if (currentTime.hour >= 18 && currentTime.hour < 20) {
      greeting = greetingList[2];
    } else if (currentTime.hour >= 20 && currentTime.hour < 24) {
      greeting = greetingList[3];
    }
  }

  // Handling indicator
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    getGreeting();
  }

  int selectedPageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderAccount(greeting: greeting),
                const SizedBox(height: 20.0),
                const CurrentAmount(),
                const SizedBox(height: 20.0),
                Text(
                  'Your Connections',
                  style: TxtStyle.style(fontSize: 20.0),
                ),
                const SizedBox(
                  height: 100,
                  child: UsersView(),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Transaction Histories',
                  style: TxtStyle.style(fontSize: 20.0),
                ),
                const SizedBox(height: 20.0),
                const SizedBox(
                  height: 100,
                  child: OperationsView(),
                ),
                const SizedBox(height: 20),
                // const ListViewAtmCard(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: mgDefaultPadding,
                      bottom: 13,
                      top: 29,
                      right: mgDefaultPadding),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Operation",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: map<Widget>(datas, (index, selected) {
                            return Container(
                              margin: const EdgeInsets.only(right: 3),
                              height: 9,
                              width: 9,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: current == index
                                    ? Colors.grey[700]
                                    : Colors.grey[300],
                              ),
                            );
                          }),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3,
                    padding: const EdgeInsets.only(left: mgDefaultPadding),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          current = index;
                          setState(() {});
                        },
                        child: OperationCard(
                          operation: datas[index],
                          operationIcon: operationIcon[index],
                          isSelected: current == index,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.easeInToLinear,
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
    );
  }

  Future<void> onTap(int index) async {
    selectedPageindex = index;
    getColor(index);
    widthUnderLine(index);
    setState(() {});
    if (selectedPageindex == 3) {
      Push.toPage(context, const ProfileView());
    }
  }

  Color getColor(int index) {
    if (selectedPageindex == index) {
      return Colors.black;
    }
    return Colors.grey;
  }

  double widthUnderLine(int index) {
    if (selectedPageindex == index) {
      return 20.0;
    }
    return 5.0;
  }
}

class CurrentAmount extends StatelessWidget {
  const CurrentAmount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '\$9839.47',
          style: TxtStyle.style(fontSize: 30.0),
        ),
        const SizedBox(width: 10.0),
        InkWell(
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.grey.shade400,
          ),
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
