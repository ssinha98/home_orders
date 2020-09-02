import 'package:flutter/material.dart';

class Vendors extends StatefulWidget {
  const Vendors({Key key}) : super(key: key);

  @override
  _VendorsState createState() => _VendorsState();
}

class _VendorsState extends State<Vendors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Your Vendors'),
            backgroundColor: Colors.black,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  print("back pressed");
                  Navigator.pop(context);
                })),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text("Your Vendors",
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              Center(
                child: DataTable(
                  columnSpacing: 30,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Orders',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Payment',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    DataColumn(
                      numeric: true,
                      label: Text(
                        'Amount',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    DataColumn(
                      numeric: true,
                      label: Text(
                        'Date',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        // vendor name
                        DataCell(Text('Sarah')),
                        // number of orders incoming
                        DataCell(Text('19')),
                        // Icon for payment method - cash, credit or card
                        DataCell(Image.asset("assets/Cash.png")),
                        // number of amount
                        DataCell(Text('200')),
                        DataCell(Text('Wed 19 July')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Amazon')),
                        DataCell(Text('43')),
                        DataCell(Icon(Icons.credit_card)),
                        DataCell(Text('4000')),
                        DataCell(Text('Wed 21 July')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('William')),
                        DataCell(Text('27')),
                        DataCell(Icon(Icons.person)),
                        DataCell(Text('454')),
                        DataCell(Text('Wed 21 July')),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
