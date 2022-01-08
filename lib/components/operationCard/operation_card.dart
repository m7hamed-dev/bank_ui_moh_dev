import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/tools/delay_animation.dart';
import 'package:flutter/material.dart';

class OperationCard extends StatefulWidget {
  const OperationCard(
      {Key? key,
      required this.operation,
      required this.operationIcon,
      required this.isSelected})
      : super(key: key);

  final String operation, operationIcon;
  final bool isSelected;

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(right: 10, top: mgDefaultPadding / 2),
      height: 117,
      width: 117,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.isSelected ? 10.0 : 5.0),
        border: Border.all(
          color: widget.isSelected
              ? Colors.black.withOpacity(.70)
              : Colors.black.withOpacity(.10),
          width: widget.isSelected ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 60.0,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                widget.operationIcon,
              ),
            )),
          ),
          // Image.asset(
          //   widget.operationIcon,
          //   fit: BoxFit.fill,
          //   height: 60.0,
          //   // width: 60.0,
          //   // color: widget.isSelected ? Colors.white : Colors.blue,
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.operation,
              style: TxtStyle.style(),
              // textAlign: TextAlign.center,
              // style: Theme.of(context).textTheme.subtitle2!.copyWith(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w700,
              //       color: widget.isSelected ? Colors.white : Colors.grey[400],
              //     ),
            ),
          ),
        ],
      ),
    );
  }
}
