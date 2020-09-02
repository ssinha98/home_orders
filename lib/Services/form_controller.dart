import 'package:hellow_world/Models/user_form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FormController {
  final void Function(String) callback;
  static const String URL =
      "https://script.google.com/macros/s/AKfycbxmlvUe9GGJlP_pqOpBQL_HiaJXY6Knsl62GAAqtH6P-tCVyZei/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(UserForm userForm) async {
    try {
      await http.get(URL + userForm.toParams()).then((response) {
        callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
    }
  }
}
