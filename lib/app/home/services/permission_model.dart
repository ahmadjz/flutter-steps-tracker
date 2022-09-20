import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionSection {
  noActivityPermission,
  noActivityPermissionPermenant,
  activitypermissionAllowed,
  notInitialized,
}

class PermissionModel extends ChangeNotifier {
  PermissionSection _permissionSection = PermissionSection.notInitialized;
  bool isBackFromSettings = false;

  void isBackFromSettingsSetter(bool value) {
    isBackFromSettings = value;
    notifyListeners();
  }

  set permissionSectionSetter(PermissionSection value) {
    if (value != _permissionSection) {
      _permissionSection = value;
      notifyListeners();
    }
  }

  PermissionSection get permissionSection => _permissionSection;

  Future<PermissionSection> initPermission() async {
    return await checkIfPermissionIsGranted(true);
  }

  Future<PermissionSection> checkIfPermissionIsGranted(bool isInit) async {
    bool isPermissionGranted = await Permission.activityRecognition.isGranted;
    if (isPermissionGranted) {
      permissionSectionSetter = PermissionSection.activitypermissionAllowed;
      return PermissionSection.activitypermissionAllowed;
    }
    if (!isInit) {
      permissionSectionSetter = PermissionSection.noActivityPermissionPermenant;
      return PermissionSection.noActivityPermissionPermenant;
    }
    permissionSectionSetter = PermissionSection.noActivityPermission;
    return PermissionSection.noActivityPermission;
  }

  Future<bool> requestActivityPermission() async {
    PermissionStatus result;
    result = await Permission.activityRecognition.request();

    if (result.isGranted) {
      permissionSectionSetter = PermissionSection.activitypermissionAllowed;
      return true;
    } else if (result.isPermanentlyDenied) {
      permissionSectionSetter = PermissionSection.noActivityPermissionPermenant;
    } else {
      permissionSectionSetter = PermissionSection.noActivityPermission;
    }
    return false;
  }
}
