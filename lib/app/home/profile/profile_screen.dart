import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/app/home/profile/widgets/bought_items_dialog.dart';
import 'package:flutter_steps_tracker/models/bought_item.dart';
import 'package:flutter_steps_tracker/services/my_database.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';
import 'package:flutter_steps_tracker/utils/show_snack_bar.dart';
import 'package:flutter_steps_tracker/widgets/avatar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.menuScreenContext});
  final BuildContext menuScreenContext;

  void onTap(BuildContext context, List<BoughtItem> allBoughtItems) {
    if (allBoughtItems.isEmpty) {
      showSnackBar(context, "You don't have any log yet");
    } else {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => BoughtItemsDialog(
                allBoughtItems: allBoughtItems,
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkGrey,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Column(
              children: const <Widget>[
                Avatar(
                  photoUrl: 'assets/logo.jpg',
                  radius: 50,
                  borderColor: activeColor,
                  borderWidth: 3.0,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Consumer<MyDatabase>(
                builder: (context, myDatabase, _) => Column(
                  children: [
                    Text(
                      "welcome\n ${myDatabase.name}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "You have\n ${myDatabase.points} Points",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: activeColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () => onTap(context, myDatabase.allBoughtItems),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              color: activeColor),
                          child: const Text(
                            'Open buy log',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
