import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/app/home/services/permission_model.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ActivityPermission extends StatelessWidget {
  final bool isPermanent;
  final VoidCallback onPressed;

  const ActivityPermission({
    Key? key,
    required this.isPermanent,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 24.0,
              right: 16.0,
            ),
            child: Text(
              'Activity permission',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 24.0,
              right: 16.0,
            ),
            child: const Text(
              'We need to request your permission to access '
              'your activity to detect your foot steps',
              textAlign: TextAlign.center,
            ),
          ),
          if (isPermanent)
            Container(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 24.0,
                right: 16.0,
              ),
              child: const Text(
                'You need to give this permission from the system settings.',
                textAlign: TextAlign.center,
              ),
            ),
          Container(
            padding: const EdgeInsets.only(
                left: 16.0, top: 24.0, right: 16.0, bottom: 24.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(activeColor)),
              onPressed: isPermanent
                  ? () {
                      openAppSettings();
                      Provider.of<PermissionModel>(context, listen: false)
                          .isBackFromSettingsSetter(true);
                    }
                  : onPressed,
              child: Text(isPermanent ? 'Open settings' : 'Allow access'),
            ),
          ),
        ],
      ),
    );
  }
}
