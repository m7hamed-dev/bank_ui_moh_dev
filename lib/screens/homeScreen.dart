import 'package:bank_ui_moh_dev/components/card/atmCard.dart';
import 'package:bank_ui_moh_dev/components/operationCard/operationCard.dart';
import 'package:bank_ui_moh_dev/components/transactionHistory/transactionHistory.dart';
import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/constants/data/cardData.dart';
import 'package:bank_ui_moh_dev/database/databaseHelper.dart';
import 'package:bank_ui_moh_dev/model/transectionDetails.dart';
import 'package:bank_ui_moh_dev/model/userData.dart';
import 'package:bank_ui_moh_dev/screens/transferMoney.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:flutter/material.dart';

import 'addCardDetails.dart';
import 'home/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper _dbhelper = new DatabaseHelper();
  String userName = "Hello! ";
  String avatar = "H";
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
      appBar: myAppBar(avatar),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: mgDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(greeting, style: TxtStyle.style(color: Colors.grey)),
                  //
                  Text(userName,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: mgBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          )),
                ],
              ),
            ),
            SizedBox(height: 20),

            //<<<<<<<<<<< ATM Card Section >>>>>>>>>>>>>>//
            Container(
              height: 199,
              child: FutureBuilder<List<UserData>>(
                initialData: [],
                future: _dbhelper.getUserDetails(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.only(left: mgDefaultPadding, right: 6),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() => {
                                userName = snapshot.data![index].userName,
                                avatar = snapshot.data![index].userName[0],
                              });
                          Push.toPage(
                            context,
                            TransferMoney(
                              currentBalance: snapshot.data![index].totalAmount,
                              currentCustomerId: snapshot.data![index].id,
                              currentUserCardNumebr:
                                  snapshot.data![index].cardNumber,
                              senderName: snapshot.data![index].userName,
                            ),
                          );
                        },
                        child: UserATMCard(
                          cardHolderName: 'card home mohamed',
                          cardNumber: snapshot.data![index].cardNumber,
                          cardExpiryDate: snapshot.data![index].cardExpiry,
                          totalAmount: snapshot.data![index].totalAmount,
                          gradientColor: _list[index].mgPrimaryGradient,
                        ),
                      );
                    },
                  );
                },
              ),
            ),

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
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
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
            Container(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: 3,
                padding: const EdgeInsets.only(left: mgDefaultPadding),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                      });
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

            Container(
              child: FutureBuilder<List<TransectionDetails>>(
                initialData: [],
                future: _dbhelper.getTransectionDetatils(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: mgDefaultPadding),
                    itemBuilder: (context, index) {
                      return TransactionHistroy(
                        isTransfer: true,
                        customerName: snapshot.data![index].userName,
                        transferAmount: snapshot.data![index].transectionAmount,
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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: mgBlueColor,
        elevation: 15,
        child: Container(
          height: 50,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mgBlueColor,
        onPressed: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 100),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                        parent: animation, curve: Curves.easeInOutCubic);
                    return ScaleTransition(
                      scale: animation,
                      alignment: Alignment.bottomCenter,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return AddCardDetails();
                  }));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
