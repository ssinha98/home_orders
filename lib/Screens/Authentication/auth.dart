import 'package:flutter/material.dart';
import 'package:hellow_world/Screens/Onboarding/signin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    // Returns either the log in + onboarding page if no user, or the Dashboard if user is signed in
    return Container(child: LoginPage());
  }
}
