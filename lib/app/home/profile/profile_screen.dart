import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.menuScreenContext});
  final BuildContext menuScreenContext;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Text("hiiii"),
          ElevatedButton(onPressed: () {}, child: Text("touch me")),
          Flexible(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
