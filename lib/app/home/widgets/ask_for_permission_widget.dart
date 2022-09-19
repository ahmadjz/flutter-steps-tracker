import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class AskForPermission extends StatelessWidget {
  const AskForPermission({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(cardBackground)),
              onPressed: () => openAppSettings(),
              child: const Text("Open settings")),
          Flexible(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
