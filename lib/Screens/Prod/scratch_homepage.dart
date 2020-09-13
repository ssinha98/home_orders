import 'package:flutter/material.dart';
import 'package:hellow_world/Screens/Prod/scratch_today.dart';
import 'package:hellow_world/Screens/Prod/scratch_todo.dart';


class ScratchHome extends StatefulWidget {
  @override
  _ScratchHomeState createState() => _ScratchHomeState();
}

class _ScratchHomeState extends State<ScratchHome> {
  PageController _homeController = PageController(
    initialPage: 0,
);

@override
void dispose() {
  _homeController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _homeController,
      scrollDirection: Axis.vertical,
      children: [
        ScratchToday(),
        ScratchToDo()
      ],
    );
  }
}