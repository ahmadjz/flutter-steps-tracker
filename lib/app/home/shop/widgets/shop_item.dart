import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/app/home/shop/models/shop.dart';
import 'package:flutter_steps_tracker/services/my_database.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';
import 'package:flutter_steps_tracker/utils/show_snack_bar.dart';
import 'package:flutter_steps_tracker/widgets/are_you_sure_dialog.dart';
import 'package:provider/provider.dart';

class ShopItem extends StatelessWidget {
  const ShopItem(
      {Key? key, required this.shop, required this.menuScreenContext})
      : super(key: key);
  final Shop shop;
  final BuildContext menuScreenContext;

  void onSubmit(BuildContext myContext) {
    final points = Provider.of<MyDatabase>(myContext, listen: false).points;
    if (points < shop.cost) {
      showSnackBar(
          myContext, "you don't have enough balance to buy ${shop.name}");
    } else if (points >= shop.cost) {
      showDialog(
          barrierDismissible: false,
          context: myContext,
          builder: (context) => AreYouSureDialog(
                onSubmit: () async {
                  await Provider.of<MyDatabase>(myContext, listen: false)
                      .buyItem(points - shop.cost, shop);
                  Navigator.of(context).pop();
                },
              ));
    }
  }

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
          height: 70,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.name,
                      style: const TextStyle(
                          fontSize: 20,
                          color: activeColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "cost: ${shop.cost}",
                      style: const TextStyle(color: darkGrey),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    onSubmit(context);
                  },
                  child: Row(
                    children: const <Widget>[
                      Text(
                        "Buy",
                        style: TextStyle(color: activeColor, fontSize: 15),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        size: 30,
                        color: activeColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
