import 'package:firebase_helpers/firebase_helpers.dart';

class OrderModel extends DatabaseItem {
  final String id;
  final String title;
  final String vendor;
  final int amount;
  final String method;
  final DateTime orderDate;

  OrderModel(
      {this.id,
      this.title,
      this.vendor,
      this.amount,
      this.method,
      this.orderDate})
      : super(id);

  factory OrderModel.fromMap(Map data) {
    return OrderModel(
        title: data['title'],
        vendor: data['vendor'],
        amount: data['amount'],
        method: data['method'],
        orderDate: data['order_date']);
  }

  factory OrderModel.fromDS(String id, Map<String, dynamic> data) {
    return OrderModel(
      id: id,
      title: data['title'],
      vendor: data['vendor'],
      amount: data['amount'],
      method: data['method'],
      orderDate: data['order_date'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "vendor": vendor,
      "method": method,
      "amount": amount,
      "order_date": orderDate,
      "id": id,
    };
  }
}
