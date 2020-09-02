import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class OrderCRUD {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  getVendors() async {
    await Firestore.instance.collection('orders').getDocuments();
  }

  Future countTodaysOrders() async {
    QuerySnapshot todaysOrders = await Firestore.instance
        .collection('orders')
        .where('order_date',
            isGreaterThan: new DateTime.now().subtract(new Duration(days: 1)))
        .where('order_date',
            isLessThan: new DateTime.now().add(new Duration(days: 1)))
        .getDocuments();
    List<DocumentSnapshot> todaysOrdersList = todaysOrders.documents;
    print(todaysOrdersList.length); // Count of Documents in Collection
  }

  Future<void> addData(vendorData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('orders').add(vendorData).catchError((e) {
        print(e);
      });
    } else {
      print("you need to be logged in");
    }
  }

  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('orders')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }
}
