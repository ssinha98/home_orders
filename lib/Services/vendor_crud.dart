import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hellow_world/Services/authenticate.dart';
import 'dart:async';

class VendorCRUD {
  AuthService auth = new AuthService();

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(vendorData) async {
    final uid = await auth.getUID();

    if (isLoggedIn()) {
      Firestore.instance
          .collection('userData')
          .document(uid)
          .collection('vendors')
          .add(vendorData)
          .catchError((e) {
        print(e);
      });
    } else {
      print("you need to be logged in");
    }
  }

  getData() async {
    final uid = await auth.getUID();
    return Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('vendors')
        .snapshots();
  }

  getVendors() async {
    final uid = await auth.getUID();
    await Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('vendors')
        .getDocuments();
  }

  updateData(selectedDoc, newValues) async {
    final uid = await auth.getUID();
    Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('vendors')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }
}
