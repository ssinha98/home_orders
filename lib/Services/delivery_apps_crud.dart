import 'package:cloud_firestore/cloud_firestore.dart';

class AppsCRUD {
  getAppsList() {
    return Firestore.instance.collection('apps').snapshots();
  }
}
