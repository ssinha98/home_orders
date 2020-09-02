import 'package:flutter/material.dart';
import 'package:hellow_world/Models/orders.dart';
import 'package:hellow_world/Screens/order_page.dart';
import 'package:hellow_world/Services/add_order_firestore.dart';
import 'package:hellow_world/Shared/Icons/payment_card.dart';
import 'package:hellow_world/Shared/Icons/payment_cash.dart';
import 'package:hellow_world/Shared/Icons/vendor_credit.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _orders;
  List<dynamic> _selectedOrders;

  @override
  void initState() {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders Coming Up'),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<List<OrderModel>>(
        // This uses the helper function to pull the list of orders into the calendar
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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    events: _orders,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                        weekendStyle:
                            TextStyle().copyWith(color: Colors.blue[800]),
                        canEventMarkersOverflow: true,
                        todayColor: Colors.black,
                        selectedColor: Theme.of(context).primaryColor,
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
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10.0)),
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
                  Container(
                      height: 110,
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
                      )),
                ],
              ),
            );
          }),
    );
  }
}
