import 'package:flutter/material.dart';
import 'package:hellow_world/Models/user.dart';
import 'package:hellow_world/Screens/new_order.dart';
import 'package:hellow_world/Services/authenticate.dart';
import 'package:hellow_world/Services/delivery_apps_crud.dart';
import 'package:hellow_world/Services/orders_crud.dart';
import 'package:hellow_world/Shared/Icons/payment_card.dart';
import 'package:hellow_world/Shared/Icons/payment_cash.dart';
import 'package:hellow_world/Shared/Icons/vendor_credit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hellow_world/Services/delivery_apps.dart';

class ScratchToday extends StatefulWidget {
  @override
  _ScratchTodayState createState() => _ScratchTodayState();
}

class _ScratchTodayState extends State<ScratchToday> {
  Stream todaysOrders;
  OrderCRUD orderCRUD = new OrderCRUD();
  User user = new User();
  AuthService _auth = new AuthService();
  Stream appsList;
  AppsCRUD appsCRUD = new AppsCRUD();

  @override
  void initState() {
    orderCRUD.getTodaysOrders().then((results) {
      setState(() {
        todaysOrders = results;
      });
    });
    super.initState();
  }

  List<AppList> deliveryApps = [
    AppList(
        appLink: 'https://swiggy.com/app',
        title: 'Swiggy',
        imageLink:
            'https://www.searchpng.com/wp-content/uploads/2019/03/Swiggy-PNG-Logo-1024x1024.png'),
    AppList(
        appLink: 'https://www.amazon.in/',
        title: 'Amazon',
        imageLink: 'https://pngimg.com/uploads/amazon/amazon_PNG5.png'),
    AppList(
        appLink: 'https://www.flipkart.com/',
        title: 'Flipkart',
        imageLink:
            'https://www.searchpng.com/wp-content/uploads/2019/01/Flipart-Logo-Icon-PNG-Image.png'),
    AppList(
        appLink: 'https://www.whatsapp.com/',
        title: 'WhatsAapp',
        imageLink:
            'https://i.pinimg.com/originals/79/dc/31/79dc31280371b8ffbe56ec656418e122.png'),
    AppList(
        title: 'Urban Company',
        appLink: 'https://www.urbancompany.com/mumbai',
        imageLink:
            'https://res-2.cloudinary.com/crunchbase-production/image/upload/c_lpad,f_auto,q_auto:eco/ncuikhb6ighwxd3jxlfv')
  ];

  List<AppList> walletApps = [
    // PayTm
    AppList(
        appLink: 'https://paytm.com',
        title: 'PayTM',
        imageLink: 'https://img.icons8.com/color/452/paytm.png'),
    // Amazon Pay
    AppList(
        appLink: 'https://pay.amazon.com/',
        title: 'Amazon Pay',
        imageLink: 'https://pngimg.com/uploads/amazon/amazon_PNG5.png'),
    // FreeCharge
    AppList(
        appLink: 'https://www.freecharge.in/',
        title: 'Freecharge',
        imageLink:
            'https://i.pinimg.com/originals/fb/8d/69/fb8d69a192999b674fd5c857c218a9dd.png'),
    // Google Pay
    AppList(
        appLink: 'https://gpay.app.goo.gl/bjy4',
        title: 'Google Pay',
        imageLink:
            'https://www.searchpng.com/wp-content/uploads/2019/02/Google-Pay-Logo-Icon-PNG.png'),
    // Jio Money
    AppList(
        title: 'Jio Money',
        appLink: 'https://www.urbancompany.com/mumbai',
        imageLink:
            'https://lh3.googleusercontent.com/W96hTdauefrmKRXGIO-R0qI9rGY-NBQQfmh1E2mlg5igSJDSAmxlch_a2h3d6ITOumI=w300')
    // MobiKwik
    // , AppList(
    //   title: 'MobiKwik',
    //   appLink: ,
    //   imageLink:
    // )
    // PhonePe

    // Ola Money

    // Citrus
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
              color: Colors.blue,
              child: Text(
                "Sign out",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _auth.signOut();
              }),
          IconButton(
            icon: Icon(
              Icons.code,
              color: Colors.white,
            ),
            onPressed: () {
              _showContactMe();
              print("show contact developer tray");
            },
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
              SizedBox(height: 10),
              Container(
                height: 110,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                // Pull list of todays orders
                child: _todaysOrderList(),
              ),
              SizedBox(height: 30),
              Text(
                "Wallets",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                // Pull list of wallets - googlepay, paytm, phonepe, Mobikwik, Amazon pay
                // For each - launch the app
                child: Container(
                  height: 90,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          walletApps.map((app) => appTemplate(app)).toList()),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Delivery",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                  height: 90,
                  width: 90,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          deliveryApps.map((app) => appTemplate(app)).toList()),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  // void _showOrderForm() {
  //   showModalBottomSheet(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //             padding: EdgeInsets.all(5),
  //             child: SingleChildScrollView(child: AddOrderForm()));
  //       });
  // }

  void _showContactMe() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
              height: 400,
              padding: EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                            "Hey! I'm Sahil, I developed this app to help people like you manage your households. It's totally free, and I'm continuing to add to it."),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                                "If you'd like to share your experience I'd love to hear about it, and maybe launch a feature bsaed on your feedback!"),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(Icons.insert_link),
                                onPressed: () {
                                  print("go to form url");
                                }),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                                "If you'd like to support this project and stay updated on what we're working on "),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(Icons.local_cafe),
                                onPressed: () {
                                  print("go to buymeacoffee link");
                                }),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ));
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
              return CircularProgressIndicator();
            }
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget appTemplate(app) {
    return InkWell(
      onTap: () async {
        print("${app.title} tapped");
        if (await canLaunch(app.appLink.toString())) {
          await launch(app.appLink.toString());
        } else {
          print("Could not launch ${app.title}");
        }
      },
      child: Container(
        height: 90,
        width: 90,
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(app.imageLink),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                      child: Text(
                    app.title,
                    textAlign: TextAlign.center,
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
