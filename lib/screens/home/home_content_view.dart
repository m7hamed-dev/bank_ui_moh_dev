import 'package:bank_ui_moh_dev/components/operationCard/operation_card.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/database/local_storage.dart';
import 'package:bank_ui_moh_dev/screens/card_bank/bank_card_model.dart';
import 'package:bank_ui_moh_dev/screens/home/home_screen.dart';
import 'package:bank_ui_moh_dev/screens/operation/operation_view.dart';
import 'package:bank_ui_moh_dev/screens/qr/send_money_via_qr_scnner_view.dart';
import 'package:bank_ui_moh_dev/screens/users/users_view.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/delay_animation.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/widgets/header_account.dart';
import 'package:flutter/material.dart';

class HomeContentView extends StatefulWidget {
  const HomeContentView({Key? key}) : super(key: key);
  // final BanckCardModel banckCardModel;

  @override
  State<HomeContentView> createState() => _HomeContentViewState();
}

class _HomeContentViewState extends State<HomeContentView> {
  int current = 0;
  List datas = ["Money Transfer", "Bank Withdraw", "Insights Tracking"];

  // Handling indicator
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  DateTime currentTime = DateTime.now();
  List<String> greetingList = [
    "Good Morning",
    "Good AfterNoon",
    "Good Evening",
    "Good Night"
  ];
  String greeting = '';
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

  @override
  void initState() {
    super.initState();
    getGreeting();
  }

  DelayAnimation _title(String data, int delay) {
    return DelayAnimation(
      slidingCurve: Curves.ease,
      duration: Duration(milliseconds: 500 + delay),
      child: Text(
        data,
        style: TxtStyle.style(fontSize: 20.0),
      ),
    );
  }

  //  LocalStorage.g

  String _current = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeaderAccount(greeting: greeting),
        const SizedBox(height: 40.0),
        const CurrentAmount(),
        const SizedBox(height: 50.0),
        _title('Your Connections', 200),
        const SizedBox(
          height: 100,
          child: UsersView(),
        ),
        const SizedBox(height: 20.0),
        _title('Transaction Histories', 500),
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Operation",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
            ),

            /// dots
            Row(
              children: map<Widget>(datas, (index, selected) {
                return AnimatedContainer(
                  curve: Curves.bounceInOut,
                  duration: const Duration(milliseconds: 800),
                  margin: const EdgeInsets.only(right: 3),
                  height: 9,
                  width: 9,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        current == index ? Colors.grey[700] : Colors.grey[300],
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
    );
  }
}
