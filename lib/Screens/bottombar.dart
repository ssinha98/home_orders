import 'package:flutter/material.dart';
import 'package:hellow_world/Screens/calendar.dart';
import 'package:hellow_world/Screens/dashboard.dart';
import 'package:hellow_world/Screens/new_order.dart';
import 'package:hellow_world/Screens/orders_by_date.dart';
import 'package:hellow_world/Screens/vendor_list.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class Bottombarnav extends StatefulWidget {
  @override
  _BottombarnavState createState() => _BottombarnavState();
}

class _BottombarnavState extends State<Bottombarnav> {
  var _currentIndex = 0;
  final List<Widget> _children = [Dashboard(), OrderByDate(), VendorList()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final iconList = <IconData>[
    Icons.home,
    Icons.calendar_today,
    // Icons.person
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: _currentIndex,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          backgroundColor: Colors.black,
          activeColor: Colors.blue,
          inactiveColor: Colors.white,
          splashColor: Colors.blue,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          onTap: (index) => setState(() => _currentIndex = index)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: _showOrderForm,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
