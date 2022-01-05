import 'dart:math';

import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/screens/home/app_bar.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications View',
                  style: TxtStyle.style(fontSize: 30.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(20, (index) {
                    return Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: _leading(),
                        title: Text(
                          'Notification $index',
                          style: TxtStyle.style(
                            fontSize: 15.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        subtitle: Text(
                          'inf',
                          style: TxtStyle.style(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _leading() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
