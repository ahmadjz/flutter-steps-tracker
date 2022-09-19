import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_steps_tracker/services/auth.dart';

class SignInManager {
  SignInManager({required this.auth, required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;
  Future<UserModel?> signInAnonymously(String name) async {
    try {
      isLoading.value = true;
      return await auth.signInAnonymously(name);
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }
}
