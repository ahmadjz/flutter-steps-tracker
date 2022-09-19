import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_steps_tracker/services/auth.dart';

class SignInManager {
  SignInManager({required this.auth, required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;
  Future<UserModel?> _signIn(Future<UserModel?> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<UserModel?> signInAnonymously() async =>
      _signIn(auth.signInAnonymously);
}
