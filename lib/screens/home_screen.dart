import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/database/databaseHelper.dart';
import 'package:bank_ui_moh_dev/screens/account/profile_view.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:flutter/material.dart';
import 'home/home_content_view.dart';
import 'notification/notification_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _dbhelper = DatabaseHelper();

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

class CurrentAmount extends StatelessWidget {
  const CurrentAmount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '\$9839.47',
          style: TxtStyle.style(
            fontSize: 30.0,
            color: Colors.green,
          ),
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
