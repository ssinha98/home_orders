import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:hellow_world/Models/orders.dart';

// This is the helper function I'm using to add and read calendar events from firebase.
// The issue I'm having is I'd like this subcollection route to be userData/[the users UID]/orders
// The vendor_crud file has a good example of this where the vendor list is saved under userData/uid/vendors
// I've commented the two places this function is used - both screens are in the Screens folder
DatabaseService<OrderModel> orderDBS = DatabaseService<OrderModel>(
    "userData/user.uid/orders",
    fromDS: (id, data) => OrderModel.fromDS(id, data),
    toMap: (order) => order.toMap());
