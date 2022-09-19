import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyDatabase with ChangeNotifier {
  MyDatabase({required this.uid, required this.name});
  final String name;
  final String uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _points = 0;

  int get points {
    return _points;
  }

  Future<void> initDatabase() async {
    final userData = await _firestore.collection("users").doc(uid).get();
    final mydoc = userData.data();
    if (mydoc?["points"] != null) {
      _points = mydoc!["points"];
    }
    print(_points);
  }
}
