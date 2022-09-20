import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/app/home/shop/utils/shops_dummy_data.dart';
import 'package:flutter_steps_tracker/app/home/shop/widgets/shop_item.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key, required this.menuScreenContext});
  final BuildContext menuScreenContext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkGrey,
          title: const Text("Shop with your points"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "List of shops:",
                  style: TextStyle(color: lighGrey, fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: shops
                      .map((shop) => ShopItem(
                            shop: shop,
                            menuScreenContext: menuScreenContext,
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
