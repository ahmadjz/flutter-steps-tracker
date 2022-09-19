import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
