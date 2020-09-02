import 'package:flutter/material.dart';
import 'package:hellow_world/Models/orders.dart';
import 'package:hellow_world/Models/user.dart';
import 'package:hellow_world/Screens/new_vendor.dart';
import 'package:hellow_world/Screens/order_page.dart';
import 'package:hellow_world/Services/add_order_firestore.dart';
import 'package:hellow_world/Services/authenticate.dart';
import 'package:hellow_world/Services/vendor_crud.dart';
import 'package:hellow_world/Shared/Icons/payment_card.dart';
import 'package:hellow_world/Shared/Icons/payment_cash.dart';
import 'package:hellow_world/Shared/Icons/vendor_credit.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hellow_world/Services/orders_crud.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthService _auth = AuthService();

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _orders;
  List<dynamic> _selectedOrders;
  Stream vendors;

  VendorCRUD vendorCrud = new VendorCRUD();
  OrderCRUD orderCRUD = new OrderCRUD();
  User user = new User();

  int _creditAmount;

  Future<bool> updateVendorCreditForm(BuildContext context, selectedDoc) async {
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
                      "Update Credit Amount",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: 'Update Credit Amount'),
                      onChanged: (value) {
                        this._creditAmount = int.parse(value);
                      },
                    ),
                    SizedBox(height: 50.0),
                    Center(
                      child: FlatButton(
                        child: Text('Update'),
                        textColor: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).pop();
                          vendorCrud.updateData(selectedDoc, {
                            'creditAmount': this._creditAmount
                          }).then((result) {
                            print("Credit updated");
                          }).catchError((e) {
                            print(e);
                          });
                        },
                      ),
                    )
                  ],
                ),
              )));
        });
  }

  @override
  void initState() {
    vendorCrud.getData().then((results) {
      setState(() {
        vendors = results;
      });
    });
    super.initState();
    _controller = CalendarController();
    _orders = {};
    _selectedOrders = [];
  }

  Map<DateTime, List<dynamic>> _groupOrders(List<OrderModel> allOrders) {
    Map<DateTime, List<dynamic>> data = {};
    allOrders.forEach((order) {
      DateTime date = DateTime(
          order.orderDate.year, order.orderDate.month, order.orderDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(order);
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    void _showVendorForm() {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.all(5), child: AddVendorForm());
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.black,
        leading: Container(),
        actions: <Widget>[
          MaterialButton(
              child: Text("TEST"),
              color: Colors.pink,
              onPressed: () async {
                orderCRUD.countTodaysOrders();
                print(await _auth.getUID());
              }),
          MaterialButton(
              child: Text(
                "Sign out",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                _auth.signOut();
                print("signed out");
              })
        ],
      ),
      body: StreamBuilder<Object>(
          stream: orderDBS.streamList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OrderModel> allOrders = snapshot.data;
              if (allOrders.isNotEmpty) {
                _orders = _groupOrders(allOrders);
              } else {
                _orders = {};
                _selectedOrders = [];
              }
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: Text("What's coming up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                      TableCalendar(
                        events: _orders,
                        initialCalendarFormat: CalendarFormat.twoWeeks,
                        calendarStyle: CalendarStyle(
                            weekendStyle:
                                TextStyle().copyWith(color: Colors.blue[800]),
                            canEventMarkersOverflow: true,
                            todayColor: Colors.black,
                            selectedColor: Colors.blueAccent,
                            todayStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white)),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle:
                              TextStyle().copyWith(color: Colors.grey[600]),
                        ),
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          formatButtonTextStyle: TextStyle(color: Colors.white),
                          formatButtonShowsNext: false,
                        ),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        onDaySelected: (date, events) {
                          setState(() {
                            _selectedOrders = events;
                          });
                        },
                        builders: CalendarBuilders(
                          selectedDayBuilder: (context, date, events) =>
                              Container(
                                  margin: const EdgeInsets.all(4.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Text(
                                    date.day.toString(),
                                    style: TextStyle(color: Colors.white),
                                  )),
                          todayDayBuilder: (context, date, events) => Container(
                              margin: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        calendarController: _controller,
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 120,
                        color: Colors.grey[100],
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            ..._selectedOrders.map((order) => Container(
                                  width: 300,
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
                                                    : order.method ==
                                                            "Vendor Credit"
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
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => OrderPage(
                                                        order: order,
                                                      )));
                                        },
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[800],
                        thickness: 1.5,
                      ),
                      Container(
                          height: 40,
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                      padding: EdgeInsets.all(9),
                                      child: Text("Your vendors",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)))),
                              Expanded(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        print("add vendor tapped");
                                        _showVendorForm();
                                      }))
                            ],
                          )),
                      SizedBox(height: 10),
                      Container(height: 100, child: _vendorList())
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _vendorList() {
    if (vendors != null) {
      return StreamBuilder(
          stream: vendors,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    return new Container(
                      width: 250,
                      child: Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          onTap: () {
                            print("open edit vendor modal");
                            updateVendorCreditForm(
                                context, snapshot.data.documents[i].documentID);
                          },
                          leading: Icon(
                            Icons.account_circle,
                            size: 40,
                          ),
                          title: Text(
                            snapshot.data.documents[i].data['vendorName'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: snapshot
                                      .data.documents[i].data['creditAmount'] !=
                                  null
                              ? Text(
                                  '₹${snapshot.data.documents[i].data['creditAmount']} in credit'
                                      .toString(),
                                  style: TextStyle(fontSize: 17))
                              : Text("No outstanding credit"),
                        ),
                      ),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  Container exampleVendorCard() {
    return Container(
        padding: EdgeInsets.all(10),
        width: 150,
        decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    child: Icon(
              Icons.person,
              color: Colors.white,
              size: 80,
            ))),
            // Column 2
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(
                          "Vendor Name",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Container examplePlatformCard() {
    return Container(
        padding: EdgeInsets.all(10),
        width: 150,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    // child: Icon(
                    //   Icons.mobile_screen_share,
                    //   color: Colors.white,
                    //   size: 80,
                    //    )
                    child: Image.asset(
              "assets/Swiggy.jpg",
            ))),
            // Column 2
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(
                          "Vendor Name",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
