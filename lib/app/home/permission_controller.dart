import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';
import 'package:flutter_steps_tracker/widgets/loading_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends StatefulWidget {
  const PermissionController({super.key});

  @override
  State<PermissionController> createState() => _PermissionControllerState();
}

class _PermissionControllerState extends State<PermissionController>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    await requestPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<bool> requestPermission() async {
    bool isPermissionGranted = await Permission.activityRecognition.isGranted;
    if (isPermissionGranted) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<bool>(
            future: requestPermission(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const LoadingScreen();
              }
              if (!snapshot.data!) {
                return Center(
                  child: Column(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                      const Text(
                        "we need the requested permission to read the steps count",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  cardBackground)),
                          onPressed: () async {
                            await openAppSettings();
                          },
                          child: const Text("Open settings")),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  ),
                );
              }
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
            }));
  }
}
