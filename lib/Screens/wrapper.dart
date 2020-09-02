import 'package:flutter/material.dart';
import 'package:hellow_world/Models/user.dart';
import 'package:hellow_world/Screens/Authentication/auth.dart';
import 'package:hellow_world/Screens/bottombar.dart';
// import 'package:hellow_world/Screens/dashboard.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      // i.e. there is no user signed in
      return Authenticate();
    } else {
      // return Dashboard();
      return Bottombarnav();
    }
  }
}
