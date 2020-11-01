import 'package:flutter/material.dart';
import 'package:hellow_world/Screens/new_vendor.dart';
import 'package:hellow_world/Services/vendor_crud.dart';
import 'package:url_launcher/url_launcher.dart';

class ScratchVendors extends StatefulWidget {
  @override
  _ScratchVendorsState createState() => _ScratchVendorsState();
}

class _ScratchVendorsState extends State<ScratchVendors> {
  Stream vendors;
  VendorCRUD vendorCrud = new VendorCRUD();
  // int _creditAmount;

  @override
  void initState() {
    vendorCrud.getData().then((results) {
      setState(() {
        vendors = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.purple),
      body: Stack(children: [
        Container(color: Colors.purple),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "Who you Order From",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child:
                  Container(padding: EdgeInsets.all(8), child: _vendorList()),
            )
          ],
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(
            Icons.add_circle_outline,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            // add a new vendor
            _showVendorForm();
          }),
    );
  }

  void _showVendorForm() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        context: context,
        builder: (context) {
          return Container(padding: EdgeInsets.all(5), child: AddVendorForm());
        });
  }

  Widget _vendorList() {
    if (vendors != null) {
      return StreamBuilder(
          stream: vendors,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, i) {
                    return new Container(
                        height: 100,
                        child: Card(
                            child: ListTile(
                          title: Text(
                            snapshot.data.documents[i].data['vendorName'],
                          ),
                          subtitle: snapshot
                                      .data.documents[i].data['creditAmount'] !=
                                  null
                              ? Text(
                                  '₹${snapshot.data.documents[i].data['creditAmount']} in credit'
                                      .toString(),
                                  style: TextStyle(fontSize: 17))
                              : Text("No outstanding credit"),
                          trailing: IconButton(
                            icon: Icon(Icons.phone),
                            onPressed: () async {
                              var intlNumber = "91" +
                                  snapshot.data.documents[i].data['phone']
                                      .toString();
                              var whatsappUrl = "https://wa.me/$intlNumber";
                              print(whatsappUrl);
                              await canLaunch(whatsappUrl)
                                  ? launch(whatsappUrl)
                                  : print(
                                      "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
                              // change to url launch phone sms, whatsapp or phone call
                            },
                          ),
                        )));
                  });
            } else {
              return Text("No vendors found :( Try adding one!");
            }
          });
    } else {
      return CircularProgressIndicator();
    }
  }
}
