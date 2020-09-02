import 'package:flutter/material.dart';
import 'package:hellow_world/Services/vendor_crud.dart';

class AddVendorForm extends StatefulWidget {
  @override
  _AddVendorFormState createState() => _AddVendorFormState();
}

class _AddVendorFormState extends State<AddVendorForm> {
  final _vendormFormKey = GlobalKey<FormState>();

  String _newVendorName;
  bool _checked = false;

  VendorCRUD vendorCrud = new VendorCRUD();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(10),
          height: 500,
          child: Form(
            key: _vendormFormKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Add a new vendor",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_add),
                      hintText: "Who's the new's vendor?'",
                      labelText: 'Vendor Name',
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _newVendorName = val),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: MaterialButton(
                        color: Colors.lightBlue,
                        child: Text("Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          // print("New Vendor Saved");
                          Navigator.pop(context);
                          print(_newVendorName);
                          // Save to firebase
                          vendorCrud.addData({
                            'vendorName': this._newVendorName
                          }).then((result) {
                            print("Saved");
                          }).catchError((e) {
                            print(e);
                          });
                        }),
                  )
                ]),
          )),
    );
  }

// make this an iterable through a list of platforms, each with it's own bool value, app name and leading icon
  CheckboxListTile selectPlatformCard() {
    return CheckboxListTile(
      title: Text("Platform or App Name"),
      secondary: Icon(Icons.account_circle),
      value: _checked,
      onChanged: (bool value) {
        setState(() {
          _checked = value;
        });
      },
    );
  }
}
