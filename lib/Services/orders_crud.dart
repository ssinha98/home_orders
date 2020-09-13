import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:hellow_world/Services/authenticate.dart';

class OrderCRUD {
  AuthService auth = new AuthService();

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(orderData) async {
    final uid = await auth.getUID();
    if (isLoggedIn()) {
      Firestore.instance
          .collection('userData')
          .document(uid)
          .collection('orders')
          .add(orderData)
          .catchError((e) {
        print(e);
      });
    } else {
      print("you need to be logged in");
    }
  }

  getTodaysOrders() async {
    final uid = await auth.getUID();
    return Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('orders')
        .where('order_date',
            isGreaterThan: new DateTime.now().subtract(new Duration(days: 1)))
        .where('order_date',
            isLessThan: new DateTime.now().add(new Duration(minutes: 1)))
        .snapshots();
  }

  getTodayAddOneOrders() async {
    final uid = await auth.getUID();
    return Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('orders')
        .where('order_date', isGreaterThan: new DateTime.now())
        .where('order_date',
            isLessThan: new DateTime.now().add(new Duration(days: 1)))
        .snapshots();
  }

  getTodayAddTwoOrders() async {
    final uid = await auth.getUID();
    return Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('orders')
        .where('order_date',
            isGreaterThan: new DateTime.now().add(new Duration(days: 1)))
        .where('order_date',
            isLessThan: new DateTime.now().add(new Duration(days: 2)))
        .snapshots();
  }

  getTodayAddThreeOrders() async {
    final uid = await auth.getUID();
    return Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('orders')
        .where('order_date',
            isGreaterThan: new DateTime.now().add(new Duration(days: 2)))
        .where('order_date',
            isLessThan: new DateTime.now().add(new Duration(days: 3)))
        .snapshots();
  }

  getTodayAddFourOrders() async {
    final uid = await auth.getUID();
    return Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('orders')
        .where('order_date',
            isGreaterThan: new DateTime.now().add(new Duration(days: 3)))
        .where('order_date',
            isLessThan: new DateTime.now().add(new Duration(days: 4)))
        .snapshots();
  }

  getData() async {
    final uid = await auth.getUID();
    return Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('orders')
        .snapshots();
  }

  getFutureData() async {
    final uid = await auth.getUID();
    return Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('orders')
        .where('order_date', isGreaterThan: DateTime.now())
        .snapshots();
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
