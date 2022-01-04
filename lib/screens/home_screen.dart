import 'package:bank_ui_moh_dev/components/operationCard/operationCard.dart';
import 'package:bank_ui_moh_dev/components/transactionHistory/transactionHistory.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/constants/data/cardData.dart';
import 'package:bank_ui_moh_dev/database/databaseHelper.dart';
import 'package:bank_ui_moh_dev/model/transectionDetails.dart';
import 'package:bank_ui_moh_dev/screens/home/listview_atm_card.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:bank_ui_moh_dev/widgets/header_account.dart';
import 'package:flutter/material.dart';
import 'card_bank/add_card_bank_view.dart';

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

  List<CardData> _list = <CardData>[];

  int current = 0;
  List datas = ["Money Transfer", "Bank Withdraw", "Insights Tracking"];

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
    _list = CardData.cardDataList;
    getGreeting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mgBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderAccount(),
              const SizedBox(height: 20.0),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: mgDefaultPadding),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(greeting, style: TxtStyle.style(color: Colors.grey)),
              //       GetUserName(userName: userName),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 20),
              //<<<<<<<<<<< ATM Card Section >>>>>>>>>>>>>>//
              const ListViewAtmCard(),
              //<<<<<<<<<<<< Operation section >>>>>>>>>>>>>//
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
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
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
                                  ? mgBlueColor
                                  : Colors.grey[400],
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

              // <<<<<<<<< Transaction Section >>>>>>>>>>>> //
              Padding(
                padding: const EdgeInsets.only(
                    left: mgDefaultPadding,
                    bottom: 13,
                    top: 29,
                    right: mgDefaultPadding),
                child: Text(
                  "Transaction Histories",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),

              ///getTransectionDetatils
              SizedBox(
                child: FutureBuilder<List<TransectionDetails>>(
                  initialData: const [],
                  future: _dbhelper.getTransectionDetatils(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: mgDefaultPadding),
                      itemBuilder: (context, index) {
                        return TransactionHistroy(
                          isTransfer: true,
                          customerName: snapshot.data![index].userName,
                          transferAmount:
                              snapshot.data![index].transectionAmount,
                          senderName: snapshot.data![index].senderName,
                          avatar: snapshot.data![index].userName[0],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: mgBlueColor,
        elevation: 15,
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mgBlueColor,
        onPressed: () {
          Push.toPageWithAnimation(context, const AddCardBank());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
