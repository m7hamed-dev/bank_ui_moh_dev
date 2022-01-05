import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/delay_animation.dart';
import 'package:flutter/material.dart';

class BioMetricView extends StatefulWidget {
  const BioMetricView({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50.0),
            const DelayAnimation(
              child: Icon(
                Icons.fingerprint,
                size: 50.0,
              ),
              duration: Duration(milliseconds: 700),
            ),
            const SizedBox(height: 20.0),
            DelayAnimation(
              child: Text(
                'bio',
                style: TxtStyle.style(fontSize: 20.0),
              ),
              duration: const Duration(milliseconds: 1200),
            ),
            const SizedBox(height: 50.0),
            _dots(),
            const SizedBox(height: 30.0),
            Expanded(
              child: _numbers(),
            )
          ],
        ),
      ),
    );
  }

  //
  Row _dots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
        (index) => Container(
          width: 20.0,
          height: 20.0,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 3.0),
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  GridView _numbers() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 4 / 2,
      ),
      itemCount: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        // clear last number
        if (index == 10) {
          return InkWell(
            onTap: onIconClearClick,
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.grey,
            ),
          );
        }
        // clear all
        if (index == 11) {
          return InkWell(
            onTap: _clearValue,
            child: const Icon(
              Icons.clear,
              color: Colors.red,
            ),
          );
        }
        return InkWell(
          onTap: () => onNumberClick(index),
          child: Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            // color: Colors.blue,
            child: Text(
              '$index',
              style: TxtStyle.style(fontSize: 30.0),
            ),
          ),
        );
      },
    );
  }
}
