import 'package:bank_ui_moh_dev/constants/constants.dart';
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
      duration: const Duration(milliseconds: 900),
      margin: const EdgeInsets.only(right: 10, top: mgDefaultPadding / 2),
      height: 117,
      width: 117,
      decoration: BoxDecoration(
        color: widget.isSelected ? Colors.black.withOpacity(.02) : Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(.06),
        //     blurRadius: 2.0,
        //     spreadRadius: 2.0,
        //     offset: const Offset(0.2, 2.0),
        //   ),
        // ],
        borderRadius: BorderRadius.circular(widget.isSelected ? 15.0 : 10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.operationIcon,
            fit: BoxFit.fill,
            height: 60.0,
            width: 60.0,
            // color: widget.isSelected ? Colors.white : Colors.blue,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.operation,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: widget.isSelected ? Colors.white : Colors.grey[400],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
