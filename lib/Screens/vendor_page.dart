import 'package:flutter/material.dart';

class VendorProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Vendor Profile"),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                print("Back tapped");
                Navigator.pop(context);
              })),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 40,
                ),
                title: Text(
                  'Vendor Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Text("Credit with Vendor: "),
                    Text("[CREDIT AMOUNT]")
                  ],
                ),
                trailing: Icon(Icons.more_vert),
                isThreeLine: true,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Upcoming Orders",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              // color: Colors.grey,
              height: 400,
              child: ListView(
                children: <Widget>[
                  buildVendorSpecificOrderCard(),
                  SizedBox(height: 2),
                  buildVendorSpecificOrderCard(),
                  SizedBox(height: 2),
                  buildVendorSpecificOrderCard(),
                  SizedBox(height: 2),
                  buildVendorSpecificOrderCard(),
                  SizedBox(height: 2),
                  buildVendorSpecificOrderCard(),
                  SizedBox(height: 2),
                  buildVendorSpecificOrderCard()
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("add order to vendor tapped");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Card buildVendorSpecificOrderCard() {
    return Card(
      elevation: 5,
      child: ListTile(
        onLongPress: () {
          print("Mark order complete");
            },
        title: Text("Order Title"),
        subtitle: Row(
          children: <Widget>[
            Text("Order Amount"),
            Text(" | "),
            Icon(Icons.credit_card)
          ],
        ),
        trailing: Text("Order Date"),
      ),
    );
  }
}
