import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var _usernameController = TextEditingController();
    var _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("BaleMoya"),
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
                _loginImageAndText(),
                _username(_usernameController),
                _password(_passwordController),
                OutlinedButton(
                  child: Text("Login"),
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   print('validated');
                    // }
                    Navigator.of(context).pushNamed('/home');
                  },
                  style: ButtonStyle(),
                ),
                _dontHaveAnAccountButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _loginImageAndText() {
  return Container(
    margin: EdgeInsets.only(
      bottom: 45,
    ),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: 10,
          ),
          child: Image.asset(
            'assets/login.png',
            height: 180,
          ),
        ),
        Text(
          'Login',
          style: TextStyle(
            fontSize: 29,
          ),
        ),
      ],
    ),
  );
}

Widget _username(_usernameController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(
      _usernameController,
      "Username",
      Icon(Icons.alternate_email),
      false,
    ),
  );
}

Widget _password(_passwordController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(
      _passwordController,
      "Password",
      Icon(Icons.lock),
      true,
    ),
  );
}

Widget _dontHaveAnAccountButton(context) {
  return Container(
    margin: EdgeInsets.all(7),
    padding: EdgeInsets.all(3),
    child: TextButton(
      onPressed: () => Navigator.pushNamed(context, '/register'),
      child: Text(
        'Don\'t Have An Account?',
      ),
    ),
  );
}

Widget _formField(_controller, _formLabel, _prefixIcon, _obscureText) {
  return TextFormField(
    controller: _controller,
    decoration: InputDecoration(
      label: Text("$_formLabel"),
      prefixIcon: _prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    obscureText: _obscureText,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Field can\'t be empty.';
      } else {
        return null;
      }
    },
  );
}
