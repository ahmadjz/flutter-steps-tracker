import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserModel {
  UserModel({required this.displayName, required this.uid});
  final String? uid;
  final String? displayName;
}

abstract class AuthBase {
  Stream<UserModel?> get onAuthStateChanged;
  UserModel? currentUser();
  Future<UserModel?> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase {
  UserModel? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(uid: user.uid, displayName: user.displayName);
  }

  @override
  Stream<UserModel?> get onAuthStateChanged {
    return FirebaseAuth.instance.authStateChanges().map(_userFromFirebase);
    //another way of writing it map((User)=> _userFromFirebase(firebaseUser
  }

  @override
  UserModel? currentUser() {
    final user = FirebaseAuth.instance.currentUser!;
    return _userFromFirebase(user);
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    final authResult = await FirebaseAuth.instance.signInAnonymously();

    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
