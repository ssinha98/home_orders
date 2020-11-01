import 'package:flutter/material.dart';
import 'package:hellow_world/Screens/Prod/scratch_calendar.dart';
import 'package:hellow_world/Screens/Prod/scratch_today.dart';
import 'package:hellow_world/Screens/Prod/scratch_vendors.dart';

class ScratchNavigator extends StatefulWidget {
  @override
  _ScratchNavigatorState createState() => _ScratchNavigatorState();
}

class _ScratchNavigatorState extends State<ScratchNavigator> {
  PageController _controller = PageController(
    initialPage: 1,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [ScratchCalendar(), ScratchToday(), ScratchVendors()],
    );
  }
}
