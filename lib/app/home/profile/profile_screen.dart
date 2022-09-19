import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/services/my_database.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';
import 'package:flutter_steps_tracker/widgets/avatar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.menuScreenContext});
  final BuildContext menuScreenContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  )
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
    );
  }
}
