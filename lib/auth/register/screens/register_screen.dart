import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = 'register';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var _fullnameController = TextEditingController();
    var _usernameController = TextEditingController();
    var _emailController = TextEditingController();
    var _phoneController = TextEditingController();
    var _passwordController = TextEditingController();
    String _dropdownValue = 'Individual';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BaleMoya'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(7),
            padding: EdgeInsets.all(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _fullname(_fullnameController),
                _username(_usernameController),
                _email(_emailController),
                _phone(_phoneController),
                _password(_passwordController),
                _dropDownMenu(_dropdownValue),
                _registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _fullname(_fullnameController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(_fullnameController, "Fullname", Icon(Icons.person),
        false, TextInputType.text),
  );
}

Widget _username(_usernameController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(_usernameController, "Username",
        Icon(Icons.alternate_email), false, TextInputType.text),
  );
}

Widget _email(_emailController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(_emailController, "Email", Icon(Icons.email), false,
        TextInputType.emailAddress),
  );
}

Widget _phone(_phoneController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(_phoneController, "Phone Number",
        Icon(Icons.phone_android), false, TextInputType.phone),
  );
}

Widget _password(_passwordController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(_passwordController, "Password", Icon(Icons.lock), true,
        TextInputType.visiblePassword),
  );
}

Widget _registerButton() {
  return OutlinedButton(
    child: Text("Register"),
    onPressed: () {},
    style: ButtonStyle(),
  );
}

Widget _formField(
    _controller, _formLabel, _prefixIcon, _obscureText, _textInputType) {
  return TextFormField(
    controller: _controller,
    keyboardType: _textInputType,
    decoration: InputDecoration(
      label: Text("$_formLabel"),
      prefixIcon: _prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    obscureText: _obscureText,
  );
}

Widget _dropDownMenu(_dropdownValue) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text("Register As: "),
      DropdownButton<String>(
        value: _dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        elevation: 16,
        // style: const TextStyle(color: Colors.deepPurple),
        // underline: Container(
        //   // height: 2,
        //   color: Colors.grey[400],
        // ),
        onChanged: (String? newValue) {
          // setState(() {
          _dropdownValue = newValue!;
          print(newValue);
          // });
        },
        items: <String>['Individual', 'Organization/Company']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ],
  );
}
