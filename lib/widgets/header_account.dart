import 'package:bank_ui_moh_dev/screens/card_bank/bank_card_model.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/delay_animation.dart';
import 'package:bank_ui_moh_dev/widgets/shimmer_img.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class HeaderAccount extends StatelessWidget {
  const HeaderAccount({
    Key? key,
    required this.greeting,
  }) : super(key: key);
  final String greeting;
  @override
  Widget build(BuildContext context) {
    final _cardStream = context.read<List<BanckCardModel>>();
    return DelayAnimation(
      duration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  greeting,
                  style: TxtStyle.style(fontSize: 12.0, color: Colors.grey),
                ),
                const SizedBox(width: 10.0),
                Text(
                  _cardStream[0].wonerName,
                  style: TxtStyle.style(fontSize: 15.0),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                    border: Border.all(width: .02),
                  ),
                  child: const CustomCahchedImg(
                    width: 40,
                    height: 40,
                    isCircleShape: true,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Welcome Back !! ',
                style: TxtStyle.style(fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
