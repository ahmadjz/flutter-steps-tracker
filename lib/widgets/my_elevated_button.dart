import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      required this.elevatedButtonHeight,
      required this.elevatedButtonWidth})
      : super(key: key);
  final String buttonText;
  final void Function() onPressed;
  final double elevatedButtonWidth;
  final double elevatedButtonHeight;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(activeColor),
        fixedSize: MaterialStateProperty.all<Size>(
            Size(elevatedButtonWidth, elevatedButtonHeight)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
