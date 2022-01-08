import 'package:bank_ui_moh_dev/database/local_storage.dart';
import 'package:flutter/material.dart';

class ScreenOnBoarding extends StatelessWidget {
  const ScreenOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalStorage.setFirstTime(false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/wallet.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20),
            //   child: Text(
            //     "A brand new experiance of managing your business",
            //     style: TextStyle(
            //       fontSize: 15,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: 20),
            //   decoration: BoxDecoration(),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.indigo[900],
            //       minimumSize: Size(250, 50),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => const AddCardBank(
            //               isAddNewCard: true,
            //               cardNumber: '',
            //             ),
            //           ));
            //     },
            //     child: Text(
            //       "Get Started Now",
            //       style: TextStyle(
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
