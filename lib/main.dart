import 'package:flutter/material.dart';
import 'package:hellow_world/Models/user.dart';
import 'package:hellow_world/Screens/wrapper.dart';
import 'package:hellow_world/Services/authenticate.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user, child: MaterialApp(home: Wrapper()));
  }
}
