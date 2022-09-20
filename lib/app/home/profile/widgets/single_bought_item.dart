import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/models/bought_item.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';

class SingleBoughtItem extends StatelessWidget {
  const SingleBoughtItem({Key? key, required this.boughtItem})
      : super(key: key);
  final BoughtItem boughtItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Color(0x14000000),
                  offset: Offset(0, 4),
                  blurRadius: 16)
            ],
            gradient:
                const LinearGradient(colors: [whiteGradient, greyGradient]),
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.infinity,
          height: 80,
          child: Center(
            child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  "You spent ${boughtItem.itemCost} health points at ${boughtItem.itemName} on ${boughtItem.date}",
                  style: const TextStyle(color: darkGrey),
                )),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
