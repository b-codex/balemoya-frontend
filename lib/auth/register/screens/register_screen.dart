import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/auth/register/bloc/register_bloc.dart';
import 'package:balemoya/auth/register/models/models.dart';
import 'package:balemoya/functions/encrypt_password.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var _fullnameController = TextEditingController();
    var _usernameController = TextEditingController();
    var _emailController = TextEditingController();
    var _phoneController = TextEditingController();
    var _passwordController = TextEditingController();
    String _dropdownValue = 'Individual';

    final bloc = BlocProvider.of<RegisterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BaleMoya'),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) async {
          if (state is RegisterFailed) {
            animatedSnackBar(
              context: context,
              message: 'Registration Failed.',
              animatedSnackBarType: AnimatedSnackBarType.error,
            );
          }
          if (state is RegisterSuccess) {
            animatedSnackBar(
              context: context,
              message: 'Registration Success.',
              animatedSnackBarType: AnimatedSnackBarType.success,
            );
            await Future.delayed(Duration(seconds: 1));
            animatedSnackBar(
              context: context,
              message: 'Please Login.',
              animatedSnackBarType: AnimatedSnackBarType.info,
            );
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Center(
              child: Container(
                margin: EdgeInsets.all(7),
                padding: EdgeInsets.all(3),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _registerImageAndText(),
                      _fullname(_fullnameController),
                      _username(_usernameController),
                      _email(_emailController),
                      _phone(_phoneController),
                      _password(_passwordController),
                      // _dropDownMenu(_dropdownValue, context, x),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Register As: "),
                          BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              if (state is UserTypeChanged) {
                                _dropdownValue = state.to;
                                return DropdownButton<String>(
                                  value: state.to,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  elevation: 16,
                                  // style: const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    // height: 2,
                                    color: Colors.grey[400],
                                  ),
                                  onChanged: (String? newValue) {
                                    bloc.add(
                                      ChangeUserType(
                                        to: newValue!,
                                      ),
                                    );
                                    _dropdownValue = newValue;
                                    print('changed to ' + _dropdownValue);
                                  },

                                  items: <String>['Individual', 'Organization']
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                );
                              }
                              return DropdownButton<String>(
                                value: _dropdownValue,
                                // hint: Text('Choose one'),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                elevation: 16,
                                // style: const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  // height: 2,
                                  color: Colors.grey[400],
                                ),
                                onChanged: (String? newValue) {
                                  bloc.add(
                                    ChangeUserType(
                                      to: newValue!,
                                    ),
                                  );
                                  _dropdownValue = newValue;
                                },

                                items: <String>['Individual', 'Organization']
                                    .map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                      OutlinedButton(
                        child: Text("Register"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            bloc.add(
                              RegisterNow(
                                registerData: RegisterModel(
                                  name: _fullnameController.text,
                                  username: _usernameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  password: hashValue(
                                    password: _passwordController.text,
                                  ),
                                  userType: _dropdownValue,
                                ),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _registerImageAndText() {
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
            'assets/register.png',
            height: 100,
          ),
        ),
        Text(
          'Register',
          style: TextStyle(
            fontSize: 29,
          ),
        ),
      ],
    ),
  );
}

Widget _fullname(_fullnameController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(
      _fullnameController,
      "Fullname",
      Icon(Icons.person),
      false,
      TextInputType.text,
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
      TextInputType.text,
    ),
  );
}

Widget _email(_emailController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(
      _emailController,
      "Email",
      Icon(Icons.email),
      false,
      TextInputType.emailAddress,
    ),
  );
}

Widget _phone(_phoneController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(
      _phoneController,
      "Phone Number",
      Icon(Icons.phone_android),
      false,
      TextInputType.phone,
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
      TextInputType.visiblePassword,
    ),
  );
}

Widget _formField(
  _controller,
  _formLabel,
  _prefixIcon,
  _obscureText,
  _textInputType,
) {
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
    validator: (value) {
      if (value!.isEmpty) {
        return 'Field can\'t be empty.';
      } else {
        return null;
      }
    },
  );
}
