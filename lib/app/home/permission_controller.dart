import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/app/home/home_page.dart';
import 'package:flutter_steps_tracker/services/my_database.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';
import 'package:flutter_steps_tracker/widgets/loading_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PermissionController extends StatefulWidget {
  const PermissionController({super.key});

  @override
  State<PermissionController> createState() => _PermissionControllerState();
}

class _PermissionControllerState extends State<PermissionController>
    with WidgetsBindingObserver {
  bool isPermissionGranted = false;
  bool askPermission = true;
  bool isOpenSetting = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<MyDatabase>(context, listen: false).initDatabase().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("object");
    await requestPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<bool> requestPermission() async {
    if (askPermission) {
      askPermission = false;
      await Permission.activityRecognition.request();
    }
    bool isGranted = await Permission.activityRecognition.isGranted;
    isPermissionGranted = isGranted;
    if (isOpenSetting) {
      isOpenSetting = false;
      setState(() {
        isPermissionGranted = isGranted;
      });
    }
    return isGranted;
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
              if (!isPermissionGranted) {
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
                            await Future.delayed(const Duration(seconds: 2));
                            isOpenSetting = true;
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
              return HomePage(menuScreenContext: context);
            }));
  }
}
