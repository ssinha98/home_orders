import 'package:flutter/material.dart';
import 'package:hellow_world/Models/user.dart';
import 'package:hellow_world/Screens/new_order.dart';
import 'package:hellow_world/Services/authenticate.dart';
import 'package:hellow_world/Services/orders_crud.dart';
import 'package:hellow_world/Shared/Icons/payment_card.dart';
import 'package:hellow_world/Shared/Icons/payment_cash.dart';
import 'package:hellow_world/Shared/Icons/vendor_credit.dart';

class ScratchToday extends StatefulWidget {
  @override
  _ScratchTodayState createState() => _ScratchTodayState();
}

class _ScratchTodayState extends State<ScratchToday> {
  Stream todaysOrders;
  OrderCRUD orderCRUD = new OrderCRUD();
  User user = new User();
  AuthService _auth = new AuthService();

  @override
  void initState() {
    orderCRUD.getTodaysOrders().then((results) {
      setState(() {
        todaysOrders = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            color: Colors.blue,
            child: Text(
              "Sign out",
              style: TextStyle(
                color: Colors.white
              ),),
            onPressed: () {
              _auth.signOut();
            }
            )
        ],
        elevation: 0.0,
      ),
      body: Stack(children: [
        Container(color: Colors.blue),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "What's happening today",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 70),
              Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                // Pull list of todays orders
                child: _todaysOrderList(),
              )
            ],
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add_circle_outline,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            _showOrderForm();
            // add order modal

          }),
    );
  }

  void _showOrderForm() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.all(5),
              child: SingleChildScrollView(child: AddOrderForm()));
        });
  }

  Widget _todaysOrderList() {
    if (todaysOrders != null) {
      return StreamBuilder(
          stream: todaysOrders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    return new Container(
                      padding: EdgeInsets.all(2),
                      width: 300,
                      child: Card(
                        color: Colors.blue,
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
              return Text("No orders yet! Add one to get started");
            }
          });
    } else {
      return CircularProgressIndicator();
    }
  }
}
