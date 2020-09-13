import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hellow_world/Models/orders.dart';
import 'package:hellow_world/Services/add_order_firestore.dart';
import 'package:hellow_world/Services/orders_crud.dart';
import 'package:hellow_world/Services/vendor_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellow_world/Services/authenticate.dart';

class AddOrderForm extends StatefulWidget {
  final OrderModel note;
  const AddOrderForm({Key key, this.note}) : super(key: key);

  @override
  _AddOrderFormState createState() => _AddOrderFormState();
}

class _AddOrderFormState extends State<AddOrderForm> {
  AuthService auth = new AuthService();

  // for saving the inputs of the order form
  final _orderFormKey = GlobalKey<FormState>();

  // the list of vendors - this should be ultimatel be pulled from the firebase list
  final List<String> vendorsDefault = ["Amazon", "Flipkart", "Swiggy"];

  VendorCRUD vendorCrud = new VendorCRUD();
  OrderCRUD orderCrud = new OrderCRUD();
  Stream vendorsFirebase;

  final List<String> paymentMethods = ["Card", "Cash", "Vendor Credit"];

  String _vendorSelected;
  TextEditingController _orderTitle;
  DateTime _orderDate;
  int _orderAmount;
  String _paymentMethod;
  bool dismissed;
  bool processing;
  String uid;
  Stream vendors;

  // Form values
  void initState() {
    vendorCrud.getVendors().then((results) {
      setState(() {
        vendors = results;
      });
    });
    super.initState();
    _orderTitle = TextEditingController(
        text: widget.note != null ? widget.note.title : "");
    _orderDate = DateTime.now();
    processing = false;
    dismissed = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(10),
          height: 500,
          child: Form(
            key: _orderFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Text(
                    "Add a new order",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _orderTitle,
                  decoration: InputDecoration(
                    icon: Icon(Icons.shopping_cart),
                    hintText: "What's coming in?'",
                    labelText: 'Order Title',
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a name' : null,
                ),
                SizedBox(height: 10),
                StreamBuilder<QuerySnapshot>(
                    stream: vendors,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) 
                        return new Text("Please wait");
                      return DropdownButtonFormField(
                        items: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return DropdownMenuItem(
                              value: document.data['vendorName'],
                              child: new Text(document.data['vendorName']));
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => _vendorSelected = val),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 150,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              // FIND AN INDIAN VERSION OF THIS
                              icon: Icon(Icons.attach_money),
                              labelText: 'Amount',
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Please enter a name' : null,
                            onChanged: (val) => setState(
                              () => _orderAmount = int.parse(val),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        " In   ",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: DropdownButtonFormField(
                            value: _paymentMethod,
                            decoration: InputDecoration(
                              labelText: ' Method',
                            ),
                            items: paymentMethods.map((method) {
                              return DropdownMenuItem(
                                value: method,
                                child: Text('$method'),
                              );
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => _paymentMethod = val),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                MaterialButton(
                    child: Text(
                      "Order Date",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.lightBlue,
                    onPressed: () async {
                      // Show date picker
                      print("Show date picker");
                      DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: _orderDate,
                          firstDate: DateTime(_orderDate.year - 5),
                          lastDate: DateTime(_orderDate.year + 5));
                      if (picked != null) {
                        setState(() {
                          _orderDate = picked;
                        });
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                processing
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: MaterialButton(
                            color: Colors.blue,
                            child: Text(
                              "Save Order",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              setState(() {
                                processing = true;
                              });
                              orderCrud.addData({
                                'title': _orderTitle.text,
                                'vendor': _vendorSelected,
                                'amount': _orderAmount,
                                'method': _paymentMethod,
                                'order_date': _orderDate
                              }).then((result) {
                                print("Saved");
                              }).catchError((e) {
                                print(e);
                              });
                              Navigator.pop(context);
                              setState(() {
                                processing = false;
                              });
                              print("Order Saved");
                            }),
                      )
              ],
            ),
          )),
    );
  }
}
