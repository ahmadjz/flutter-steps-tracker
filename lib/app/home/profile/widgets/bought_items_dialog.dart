import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/app/home/profile/widgets/single_bought_item.dart';
import 'package:flutter_steps_tracker/models/bought_item.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';
import 'package:flutter_steps_tracker/widgets/my_alert_dialog.dart';

class BoughtItemsDialog extends StatelessWidget {
  const BoughtItemsDialog({Key? key, required this.allBoughtItems})
      : super(key: key);
  final List<BoughtItem> allBoughtItems;
  @override
  Widget build(BuildContext context) {
    return MyAlertDialog(
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width * 0.80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: darkGrey,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: allBoughtItems
                    .map((boughtItem) =>
                        SingleBoughtItem(boughtItem: boughtItem))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
