import 'package:flutter/material.dart';
// import 'package:hellow_world/Screens/dashboard.dart';
import 'package:hellow_world/Services/authenticate.dart';
import 'package:hellow_world/Services/form_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Pulling in auth service functions into sign in widget
  final AuthService _auth = AuthService();

  // Text controllers for user fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: ClipPath(
                    clipper: ClippingClass(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 320.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/multicoloured.jpg"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                SizedBox(height: 90),
                Padding(
                  padding: EdgeInsets.fromLTRB(34.0, 8.0, 34.10, 0),
                  // child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xff000c68),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(34.0, 8.0, 34.10, 0),
                  // child: Center(
                  child: Text(
                    "Welcome back",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Color(0xff000c68),
                        fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: 20),
                // Save these so we can set up some SMS alert systems
                Padding(
                    padding: EdgeInsets.fromLTRB(34.0, 8.0, 34.10, 0),
                    // child: Center(
                    child: TextFormField(
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return "Enter Valid Name";
                      //   }
                      //   return null;
                      // },
                      // controller: nameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'What do we call you??',
                        labelText: 'Name',
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(34.0, 8.0, 34.10, 0),
                    // child: Center(
                    child: TextFormField(
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return "Enter Valid Name";
                      //   }
                      //   return null;
                      // },
                      // controller: phoneNumberController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        hintText: "How do we reach you??",
                        labelText: 'Phone number',
                      ),
                    )),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.fromLTRB(44.0, 8.0, 44.0, 8.0),
                  child: Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color(0xff000637),
                      child: GestureDetector(
                        onTap: () async {
                          print("Log in tapped");
                          // Sign in anonymous
                          dynamic result = await _auth.signInAnon();
                          if (result == null) {
                            print('error signing in');
                          } else {
                            print('user signed in');
                            print(result.uid);
                          }
                        },
                        child: Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    path.quadraticBezierTo(
        size.width / 2, size.height - 90, size.width, size.height - 90);
    // path.quadraticBezierTo(size.width , size.height,
    //     size.width, size.height );

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
