import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/app/home/home_page.dart';
import 'package:flutter_steps_tracker/app/home/services/permission_model.dart';
import 'package:flutter_steps_tracker/app/home/widgets/activity_permission.dart';
import 'package:flutter_steps_tracker/services/my_database.dart';
import 'package:flutter_steps_tracker/widgets/loading_screen.dart';
import 'package:provider/provider.dart';

class PermissionControllerScreen extends StatefulWidget {
  const PermissionControllerScreen({Key? key}) : super(key: key);

  @override
  State<PermissionControllerScreen> createState() =>
      _PermissionControllerScreenState();
}

class _PermissionControllerScreenState extends State<PermissionControllerScreen>
    with WidgetsBindingObserver {
  late final PermissionModel _model;
  bool _detectPermission = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _model = PermissionModel();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Future.wait([
        Provider.of<MyDatabase>(context, listen: false).initDatabase(),
        Provider.of<PermissionModel>(context, listen: false).initPermission(),
        _model.initPermission(),
      ]).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final myPermissionModel =
        Provider.of<PermissionModel>(context, listen: false);
    if (state == AppLifecycleState.resumed &&
        myPermissionModel.isBackFromSettings) {
      myPermissionModel.checkIfPermissionIsGranted(false);
      myPermissionModel.isBackFromSettingsSetter(false);
    }
    if (state == AppLifecycleState.resumed &&
        _detectPermission &&
        (_model.permissionSection == PermissionSection.noActivityPermission)) {
      _detectPermission = false;
      _model.requestActivityPermission();
    } else if (state == AppLifecycleState.paused &&
        _model.permissionSection == PermissionSection.noActivityPermission) {
      _detectPermission = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const LoadingScreen()
        : Consumer<PermissionModel>(
            builder: (context, model, child) {
              Widget widget;
              switch (model.permissionSection) {
                case PermissionSection.noActivityPermission:
                  widget = ActivityPermission(
                      isPermanent: false, onPressed: _checkPermissions);
                  break;
                case PermissionSection.activitypermissionAllowed:
                  widget = HomePage(menuScreenContext: context);
                  break;
                case PermissionSection.notInitialized:
                  widget = const Text("Not Initialized");
                  break;
                case PermissionSection.noActivityPermissionPermenant:
                  widget = ActivityPermission(
                      isPermanent: true, onPressed: _checkPermissions);
                  break;
              }

              return Scaffold(
                body: widget,
              );
            },
          );
  }

  Future<void> _checkPermissions() async {
    await Provider.of<PermissionModel>(context, listen: false)
        .requestActivityPermission();
    await _model.checkIfPermissionIsGranted(false);
  }
}
