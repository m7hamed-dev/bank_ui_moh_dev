import 'package:bank_ui_moh_dev/constants/constants.dart';
import 'package:bank_ui_moh_dev/style/txt_style.dart';
import 'package:bank_ui_moh_dev/widgets/custom_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'operation_controller.dart';

class OperationsView extends StatelessWidget {
  const OperationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: OperationsController().getALL(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return const CustomLoading();
        }
        final _operarations = snapshot.data!.docs;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          // padding: const EdgeInsets.symmetric(horizontal: mgDefaultPadding),
          itemCount: _operarations.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CardOperation(operation: _operarations[index]);
          },
        );
      },
    );
  }
}

class CardOperation extends StatelessWidget {
  const CardOperation({Key? key, required this.operation}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> operation;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(.02),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ListTile(
        title: Text(
          operation['op_name'],
          style: TxtStyle.style(),
        ),
        subtitle: Text(
          '1 Jan 2022',
          style: TxtStyle.style(
            fontSize: 11.0,
            color: Colors.grey,
          ),
        ),
        leading: const CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(Constant.userImageUrl),
        ),
        trailing: Text(
          '\$ ' + operation['amount'],
          style: TxtStyle.style(fontSize: 12.0),
        ),
      ),
    );
  }
}
