import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Database {}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;
}
