class UserForm {
  String _name;
  String _phoneNumber;

  UserForm(this._name, this._phoneNumber);

  String toParams() => "?name=$_name&phone_number=$_phoneNumber";
}
