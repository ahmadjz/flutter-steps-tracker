import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      content: child,
    );
  }
}
