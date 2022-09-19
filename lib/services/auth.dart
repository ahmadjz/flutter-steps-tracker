import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<UserModel?> signInAnonymously(String name);
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
  }

  @override
  UserModel? currentUser() {
    final user = FirebaseAuth.instance.currentUser!;
    return _userFromFirebase(user);
  }

  @override
  Future<UserModel?> signInAnonymously(String name) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final authResult = await auth.signInAnonymously().then((value) {
      firestore.collection("users").doc(value.user!.uid).set({"name": name});
      return value;
    });

    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
