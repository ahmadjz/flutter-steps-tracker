import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.transparent,
          width: 50,
          height: 50,
          child: const LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader,
              colors: [blueColor],
              backgroundColor: Colors.transparent,
              pathBackgroundColor: Colors.black),
        ),
      ],
    ));
  }
}
