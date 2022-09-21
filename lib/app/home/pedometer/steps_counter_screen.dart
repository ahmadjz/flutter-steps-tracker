import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/services/my_database.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';
import 'package:flutter_steps_tracker/utils/show_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class StepsCounterScreen extends StatefulWidget {
  const StepsCounterScreen({super.key, required this.menuScreenContext});
  final BuildContext menuScreenContext;

  @override
  State<StepsCounterScreen> createState() => _StepsCounterScreenState();
}

class _StepsCounterScreenState extends State<StepsCounterScreen> {
  double x = 0.0;

  double y = 0.0;

  double z = 0.0;

  int steps = 1;

  double distance = 0.0;

  double previousDistacne = 0.0;

  double getValue(double x, double y, double z) {
    double magnitude = sqrt(x * x + y * y + z * z);
    getPreviousValue();
    double modDistance = magnitude - previousDistacne;
    setPreviousValue(magnitude);
    return modDistance;
  }

  void getPoints() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showSnackBar(context, "Congrats you got 50 points");
      Provider.of<MyDatabase>(context, listen: false).updatePoints();
    });
  }

  void setPreviousValue(double distance) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("preValue", distance);
  }

  void getPreviousValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      previousDistacne = pref.getDouble("preValue") ?? 0.0;
    });
  }

  Widget stepsBuilder(
      BuildContext context, AsyncSnapshot<AccelerometerEvent> snapshot) {
    if (snapshot.hasData) {
      x = snapshot.data!.x;
      y = snapshot.data!.y;
      z = snapshot.data!.z;
      distance = getValue(x, y, z);

      if (distance > 7) {
        steps++;
      }
      if (steps % 10 == 0) {
        steps++;
        getPoints();
      }
      return Text(
        "You walked ${steps} steps",
        style: const TextStyle(fontSize: 20),
      );
    }
    return const Text("No data");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkGrey,
          title: const Text("Steps Counter"),
          actions: [
            IconButton(
                onPressed: () {
                  showSnackBar(context,
                      "For each 10 steps you walk, you get 50 Health points");
                },
                icon: const Icon(Icons.question_mark_rounded))
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              StreamBuilder<AccelerometerEvent>(
                  stream: SensorsPlatform.instance.accelerometerEvents,
                  builder: stepsBuilder),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
