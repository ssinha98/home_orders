import 'package:flutter/material.dart';
import 'package:hellow_world/Models/orders.dart';
import 'package:hellow_world/Shared/Icons/payment_card.dart';
import 'package:hellow_world/Shared/Icons/payment_cash.dart';
import 'package:hellow_world/Shared/Icons/vendor_credit.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatelessWidget {
  final OrderModel order;
  const OrderPage({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("MEd");

    bool dismissed = false;

    return Scaffold(
        appBar: AppBar(
            title: Text(dateFormat.format(order.orderDate)),
            backgroundColor: Colors.black,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  print("back pressed");
                  Navigator.pop(context);
                })),
        body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 350,
                        height: 100,
                        child: Card(
                          color: Colors.black87,
                          elevation: 5,
                          child: Center(
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: order.method == "Card"
                                      ? CardIcon()
                                      : order.method == "Cash"
                                          ? CashIcon()
                                          : order.method == "Vendor Credit"
                                              ? VendorCreditIcon()
                                              : CashIcon()),
                              title: Text(
                                order.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                order.vendor,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                '₹${order.amount.toString()}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            )));
  }
}
