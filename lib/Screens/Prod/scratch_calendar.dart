import 'package:flutter/material.dart';
import 'package:hellow_world/Services/orders_crud.dart';
import 'package:hellow_world/Shared/Icons/payment_card.dart';
import 'package:hellow_world/Shared/Icons/payment_cash.dart';
import 'package:hellow_world/Shared/Icons/vendor_credit.dart';
import 'package:intl/intl.dart';

class ScratchCalendar extends StatefulWidget {
  @override
  _ScratchCalendarState createState() => _ScratchCalendarState();
}

class _ScratchCalendarState extends State<ScratchCalendar> {
  OrderCRUD orderCRUD = new OrderCRUD();
  Stream todaysOrders;
  Stream todayAddOneOrders;
  Stream todayAddTwoOrders;
  Stream todayAddThreeOrders;
  Stream todayAddFourOrders;

  @override
  void initState() {
    orderCRUD.getTodaysOrders().then((results) {
      setState(() {
        todaysOrders = results;
      });
    });
    orderCRUD.getTodayAddOneOrders().then((results) {
      setState(() {
        todayAddOneOrders = results;
      });
    });
    orderCRUD.getTodayAddTwoOrders().then((results) {
      setState(() {
        todayAddTwoOrders = results;
      });
    });
    orderCRUD.getTodayAddThreeOrders().then((results) {
      setState(() {
        todayAddThreeOrders = results;
      });
    });
    orderCRUD.getTodayAddFourOrders().then((results) {
      setState(() {
        todayAddFourOrders = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0.0,
      ),
      body: Stack(children: [
        Container(
          color: Colors.orange,
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "What's coming up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.orange,
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 200,
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Text(
                              DateFormat.MEd().format(
                                DateTime.now(),
                              ),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(height: 150, child: _todaysOrders())
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 200,
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Text(
                              DateFormat.MEd().format(
                                  DateTime.now().add(Duration(days: 1))),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(height: 150, child: _todayAddOneOrders())
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 200,
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Text(
                              DateFormat.MEd().format(
                                  DateTime.now().add(Duration(days: 2))),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(height: 150, child: _todayAddTwoOrders())
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 200,
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Text(
                              DateFormat.MEd().format(
                                  DateTime.now().add(Duration(days: 3))),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                                height: 150, child: _todayAddThreeOrders())
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 200,
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Text(
                              DateFormat.MEd().format(
                                  DateTime.now().add(Duration(days: 4))),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(height: 150, child: _todayAddFourOrders())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget _todaysOrders() {
    if (todaysOrders != null) {
      return StreamBuilder(
          stream: todaysOrders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    return new Container(
                      height: 100,
                      width: 300,
                      padding: EdgeInsets.all(2),
                      child: Card(
                        color: Colors.yellow[700],
                        child: ListTile(
                          onTap: () {
                            print("Open order modal");
                          },
                          leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: snapshot
                                          .data.documents[i].data['method'] ==
                                      "Card"
                                  ? CardIcon()
                                  : snapshot.data.documents[i].data['method'] ==
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
                            snapshot.data.documents[i].data['vendor'],
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
                        ),
                      ),
                    );
                  });
            } else {
              return Text("Nothing for today!");
            }
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _todayAddOneOrders() {
    if (todayAddOneOrders != null) {
      return StreamBuilder(
          stream: todayAddOneOrders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    return new Container(
                      height: 100,
                      width: 300,
                      padding: EdgeInsets.all(2),
                      child: Card(
                        color: Colors.yellow[700],
                        child: ListTile(
                          onTap: () {
                            print("Open order modal");
                          },
                          leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: snapshot
                                          .data.documents[i].data['method'] ==
                                      "Card"
                                  ? CardIcon()
                                  : snapshot.data.documents[i].data['method'] ==
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
                            snapshot.data.documents[i].data['vendor'],
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
                        ),
                      ),
                    );
                  });
            } else {
              return Text("Nothing for today!");
            }
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _todayAddTwoOrders() {
    if (todayAddTwoOrders != null) {
      return StreamBuilder(
          stream: todayAddTwoOrders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    return new Container(
                      height: 100,
                      width: 300,
                      padding: EdgeInsets.all(2),
                      child: Card(
                        color: Colors.yellow[700],
                        child: ListTile(
                          onTap: () {
                            print("Open order modal");
                          },
                          leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: snapshot
                                          .data.documents[i].data['method'] ==
                                      "Card"
                                  ? CardIcon()
                                  : snapshot.data.documents[i].data['method'] ==
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
                            snapshot.data.documents[i].data['vendor'],
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
                        ),
                      ),
                    );
                  });
            } else {
              return Text("Nothing for today!");
            }
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _todayAddThreeOrders() {
    if (todayAddThreeOrders != null) {
      return StreamBuilder(
          stream: todayAddThreeOrders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    return new Container(
                      height: 100,
                      width: 300,
                      padding: EdgeInsets.all(2),
                      child: Card(
                        color: Colors.yellow[700],
                        child: ListTile(
                          onTap: () {
                            print("Open order modal");
                          },
                          leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: snapshot
                                          .data.documents[i].data['method'] ==
                                      "Card"
                                  ? CardIcon()
                                  : snapshot.data.documents[i].data['method'] ==
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
                            snapshot.data.documents[i].data['vendor'],
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
                        ),
                      ),
                    );
                  });
            } else {
              return Text("Nothing for today!");
            }
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _todayAddFourOrders() {
    if (todayAddFourOrders != null) {
      return StreamBuilder(
          stream: todayAddFourOrders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    return new Container(
                      height: 100,
                      width: 300,
                      padding: EdgeInsets.all(2),
                      child: Card(
                        color: Colors.yellow[700],
                        child: ListTile(
                          onTap: () {
                            print("Open order modal");
                          },
                          leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: snapshot
                                          .data.documents[i].data['method'] ==
                                      "Card"
                                  ? CardIcon()
                                  : snapshot.data.documents[i].data['method'] ==
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
                            snapshot.data.documents[i].data['vendor'],
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
                        ),
                      ),
                    );
                  });
            } else {
              return Text("Nothing for today!");
            }
          });
    } else {
      return CircularProgressIndicator();
    }
  }
}
