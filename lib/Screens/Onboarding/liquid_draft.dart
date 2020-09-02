// import 'package:flutter/material.dart';
// import 'package:liquid_swipe/liquid_swipe.dart';

// class OnboardingLiquid extends StatefulWidget {
//   @override
//   _OnboardingLiquidState createState() => _OnboardingLiquidState();
// }

// class _OnboardingLiquidState extends State<OnboardingLiquid> {
//   final _userFormKey = GlobalKey<FormState>();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();

//   void _submitForm() {
//     if (_userFormKey.currentState.validate()) {
//       UserForm userForm =
//           UserForm(nameController.text, phoneNumberController.text);
//       FormController formController = FormController((String response) {
//         print(response);
//         if (response == FormController.STATUS_SUCCESS) {
//           _showSnackBar("All set!");
//         } else {
//           _showSnackBar("Ope something happened, try again!");
//         }
//       });
//       formController.submitForm(userForm);
//     }
//   }

//   _showSnackBar(String message) {
//     final snackbar = SnackBar(
//       content: Text(message),
//     );
//     _scaffoldKey.currentState.showSnackBar(snackbar);
//   }

//   final pages = [
//     Scaffold(
//       key: _scaffoldKey,
//         body: Form(
//           key: _userFormKey,
//           child: Container(
//             color: Colors.red,
//             child: Center(
//                 child: Text(
//                     "Page 1: Welcome - we take the headache out of managing your home")),
//             ),
//         )
//         ),
//     Scaffold(
//       body: Container(
//           color: Colors.blue,
//           child: Center(
//               child: Text(
//                   "Page 2: tell us about yourself - what's your name, how do we reach you?")),
//           )
//     ),
//     Scaffold(
//       body: Container(
//           color: Colors.blue,
//           child: Center(
//               child: Text(
//                   "Page 3: get started - add some of your common vendors, and some orders you're expecting this week"))),
//           ),
//   ];

//   int page = 0;

//   @override
//   Widget build(BuildContext context) {
//     return LiquidSwipe(
//       pages: pages,
//       enableSlideIcon: true,
//     );
//   }
// }
