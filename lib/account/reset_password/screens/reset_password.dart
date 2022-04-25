import 'package:balemoya/auth/login/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);
  static const routeName = '/reset_password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }
}

PreferredSizeWidget _appBar() {
  return AppBar(
    title: Text("Reset Password"),
    centerTitle: true,
  );
}

Widget _body(context) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _usernameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();

  return SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text(
                    'Please provide the information asked below',
                    overflow: TextOverflow.visible,
                    maxLines: null,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              )
            ],
          ),
          _name(_nameController),
          _username(_usernameController),
          _email(_emailController),
          _phone(_phoneController),
          _submitButton(context),
        ],
      ),
    ),
  );
}

Widget _name(_nameController) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: _formField(
      _nameController,
      "Name",
    ),
  );
}

Widget _username(_usernameController) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: _formField(
      _usernameController,
      "Username",
    ),
  );
}

Widget _email(_emailController) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: _formField(
      _emailController,
      "Email",
    ),
  );
}

Widget _phone(_phoneController) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: _formField(
      _phoneController,
      "Phone Number",
    ),
  );
}

Widget _submitButton(context) {
  return Container(
    margin: EdgeInsets.only(
      top: 35,
    ),
    child: ElevatedButton(
      onPressed: () {
        var _alertDialog = AlertDialog(
          title: Text('Confirmation'),
          content: Text(
              'The information you entered has been sent to the admin.\nWe will be in touch soon.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext ctx) => LoginScreen(),
                  ),
                );
              },
              child: Text('Ok'),
            ),
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return _alertDialog;
          },
        );
      },
      child: Text("Submit"),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(400, 50),
      ),
    ),
  );
}

Widget _formField(_controller, _formLabel) {
  return TextFormField(
    controller: _controller,
    decoration: InputDecoration(
      label: Text("$_formLabel"),
      // prefixIcon: _prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Field can\'t be empty.';
      } else {
        return null;
      }
    },
  );
}
