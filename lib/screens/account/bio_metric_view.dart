import 'package:bank_ui_moh_dev/screens/account/auth_biometric_login_view.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/delay_animation.dart';
import 'package:flutter/material.dart';

class BioMetricView extends StatefulWidget {
  const BioMetricView({Key? key, required this.amountTransfer})
      : super(key: key);
  final String amountTransfer;
  @override
  State<BioMetricView> createState() => _BioMetricViewState();
}

class _BioMetricViewState extends State<BioMetricView> {
  String _value = '\$';
  //
  void onNumberClick(int number) {
    if (_value == '0.0') {
      _value = '';
      setState(() {});
    }
    _value += '$number';
    setState(() {});
  }

  void onIconClearClick() {
    if (_value.isNotEmpty) {
      // ['a', 'a', 'a', 'b', 'c', 'd']
      List<String> c = _value.split('');
      // ['a', 'a', 'a', 'b', 'c']
      c.removeLast();
      _value = c.join();
      setState(() {});
    } else {
      _value = '0.0';
      setState(() {});
    }
  }

  void _clearValue() {
    _value = '0.0';
    setState(() {});
  }

  Color bioColor = Colors.black;
  double sizeBio = 50.0;

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Text(
                  'Scan Your Bio To Complete Proccess !',
                  style: TxtStyle.style(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: Text(
                    widget.amountTransfer,
                    style: TxtStyle.style(
                      fontSize: 20.0,
                      color: bioColor,
                    ),
                  ),
                ),
                const SizedBox(height: 80.0),
                Center(
                  child: InkWell(
                    onTap: () {
                      BioAuthAPI().startAuthBio().then((value) {
                        if (value) {
                          bioColor = Colors.green;
                          sizeBio = 90.0;
                          setState(() {});
                        } else {
                          bioColor = Colors.red;
                          sizeBio = 60.0;
                          setState(() {});
                        }
                      });
                    },
                    child: Icon(
                      Icons.fingerprint,
                      size: sizeBio,
                      color: bioColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                DelayAnimation(
                  duration: const Duration(milliseconds: 1200),
                  child: Text(
                    'your bio',
                    style: TxtStyle.style(fontSize: 30.0),
                  ),
                ),
              ].map((e) {
                print('e = ${e.key}');
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DelayAnimation(
                    duration: const Duration(milliseconds: 1200),
                    child: Center(
                      child: e,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  // GridView _numbers() {
  //   return GridView.builder(
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 3,
  //       mainAxisSpacing: 1.0,
  //       crossAxisSpacing: 0.0,
  //       childAspectRatio: 4 / 2,
  //     ),
  //     itemCount: 12,
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemBuilder: (BuildContext context, int index) {
  //       // clear last number
  //       if (index == 10) {
  //         return InkWell(
  //           onTap: onIconClearClick,
  //           child: const Icon(
  //             Icons.arrow_back_rounded,
  //             color: Colors.grey,
  //           ),
  //         );
  //       }
  //       // clear all
  //       if (index == 11) {
  //         return InkWell(
  //           onTap: _clearValue,
  //           child: const Icon(
  //             Icons.clear,
  //             color: Colors.red,
  //           ),
  //         );
  //       }
  //       return InkWell(
  //         onTap: () => onNumberClick(index),
  //         child: Container(
  //           margin: const EdgeInsets.all(10.0),
  //           alignment: Alignment.center,
  //           // color: Colors.blue,
  //           child: Text(
  //             '$index',
  //             style: TxtStyle.style(fontSize: 30.0),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

}
