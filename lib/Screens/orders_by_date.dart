import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellow_world/Services/orders_crud.dart';
import 'package:hellow_world/Shared/Icons/payment_card.dart';
import 'package:hellow_world/Shared/Icons/payment_cash.dart';
import 'package:hellow_world/Shared/Icons/vendor_credit.dart';
import 'package:intl/intl.dart';

class OrderByDate extends StatefulWidget {
  @override
  _OrderByDateState createState() => _OrderByDateState();
}

class _OrderByDateState extends State<OrderByDate> {
  DateTime _selectedDate = DateTime.now();
  OrderCRUD orderCRUD = new OrderCRUD();
  Stream orders;
  final firestoreInstance = Firestore.instance;
  bool orderDone = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }
  
  void initState() {
    orderCRUD.getFutureData().then((results) {
      setState(() {
        orders = results;
      });
    });
  }

  Future<bool> updateOrderForm(BuildContext context, selectedDoc) async {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                  child: Container(
                height: 350,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Update Order Date",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                        color: Colors.pink,
                        child: Icon(Icons.calendar_today),
                        onPressed: () => print("open order modal")),
                    SizedBox(height: 50.0),
                    Center(
                      child: FlatButton(
                        child: Text('Update'),
                        textColor: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pseudo-Calendar"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 10,
            ),
            Container(
                width: double.infinity,
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          _selectedDate = DateTime.now();
                          print(_selectedDate);
                          
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          width: 100,
                          child: Center(
                              child: Text(
                            DateFormat.MEd().format(DateTime.now()),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = DateTime.now().add(Duration(days: 1));
                          print(_selectedDate);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          width: 100,
                          child: Center(
                            child: Text(
                              DateFormat.MEd().format(
                                  DateTime.now().add(Duration(days: 1))),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = DateTime.now().add(Duration(days: 2));
                          print(_selectedDate);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          width: 100,
                          child: Center(
                            child: Text(
                              DateFormat.MEd().format(
                                  DateTime.now().add(Duration(days: 2))),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 100,
                        child: MaterialButton(
                          color: Colors.blue,
                          onPressed: () async {
                            print("Select Day ");
                            _selectDate(context);
                            print(_selectedDate);
                          },
                          child: Text(
                            "Select Day",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Expanded(child: Container(child: _orderList())),
          ],
        ),
      ),
    );
  }

  Widget _orderList() {
    if (orders != null) {
      return StreamBuilder(
          stream: orders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    return new Container(
                        width: 300,
                        height: 100,
                        child: Card(
                            color: Colors.black87,
                            child: ListTile(
                              onTap: () {
                                print("edit order");
                                updateOrderForm(context,
                                    snapshot.data.documents[i].documentID);
                              },
                              leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: snapshot.data.documents[i]
                                              .data['method'] ==
                                          "Card"
                                      ? CardIcon()
                                      : snapshot.data.documents[i]
                                                  .data['method'] ==
                                              "Cash"
                                          ? CashIcon()
                                          : snapshot.data.documents[i]
                                                      .data['method'] ==
                                                  "Vendor Credit"
                                              ? VendorCreditIcon()
                                              : CashIcon()),
                              title: Text(
                                snapshot.data.documents[i].data['title'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${snapshot.data.documents[i].data['vendor']} | due on ${DateFormat.MEd().format((snapshot.data.documents[i].data['order_date'].toDate()))}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                '₹${snapshot.data.documents[i].data['amount'].toString()}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )));
                  });
            } else {
              return CircularProgressIndicator();
            }
          });
    } else {
      return CircularProgressIndicator();
    }
  }
}
