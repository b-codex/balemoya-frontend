import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/auth/register/bloc/register_bloc.dart';
import 'package:balemoya/auth/register/models/models.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var _fullnameController = TextEditingController();
    // var _usernameController = TextEditingController();
    var _descriptionController = TextEditingController();
    var _locationController = TextEditingController();
    var _emailController = TextEditingController();
    var _phoneController = TextEditingController();
    var _passwordController = TextEditingController();
    String _dropdownValue = 'Individual';

    final bloc = BlocProvider.of<RegisterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BaleMoya'),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) async {
          /// Checking if the state is RegisterFailed, if it is, it will show a snackbar with the
          /// message.
          if (state is RegisterFailed) {
            animatedSnackBar(
              context: context,
              message: 'Registration Failed. ' + state.message,
              animatedSnackBarType: AnimatedSnackBarType.error,
            );
          }

          /// Showing a snackbar with a message and then after 1 second it is showing another snackbar
          /// with another message and then it is navigating to the login page.
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
                      // _username(_usernameController),
                      _email(_emailController),
                      _phone(_phoneController),
                      _location(_locationController),

                      /// anonymous function that adds an extra widget if user wants to register as Organization
                      (() {
                        if (_dropdownValue == "Organization") {
                          return _description(_descriptionController);
                        }

                        return SizedBox(
                          height: 0,
                        );
                      }()),

                      _password(_passwordController),
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
                                  },

                                  /// Creating a list of DropdownMenuItem<String> and then converting it
                                  /// to a list.
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

                                /// Creating a list of dropdown items.
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

                      /// A BlocBuilder which is a Flutter widget that requires a Bloc and a builder
                      /// function. BlocBuilder handles building the widget in response to new states.
                      /// BlocBuilder is very similar to StreamBuilder but has a more simple API to
                      /// reduce the amount of boilerplate code needed.
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: ((context, state) {
                          if (state is Loading) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 7,
                              ),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  fixedSize: const Size(400, 50),
                                ),
                                onPressed: null,
                                child: loading(),
                              ),
                            );
                          }

                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 7,
                            ),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                fixedSize: const Size(400, 50),
                                backgroundColor: Colors.indigo,
                              ),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  bloc.add(
                                    RegisterNow(
                                      registerData: RegisterModel(
                                          name: _fullnameController.text,
                                          email: _emailController.text,
                                          phone: _phoneController.text,
                                          password: _passwordController.text,
                                          location: _locationController.text,
                                          userType: _dropdownValue,
                                          description:
                                              _descriptionController.text),
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        }),
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

/// _registerImageAndText() returns a Container widget that contains a Column widget that contains a
/// Container widget that contains an Image widget and a Text widget.
/// 
/// Returns:
///   A widget that is a container with a column inside of it.
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

/// _fullname is a function that returns a Container widget that contains a _formField widget.
/// 
/// Args:
///   _fullnameController: The controller for the textField
/// 
/// Returns:
///   A Container widget with a child of a _formField widget.
Widget _fullname(_fullnameController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(
      _fullnameController,
      "Fullname",
      Icon(Icons.person),
      false,
      TextInputType.text,
      1,
    ),
  );
}

/// _location is a function that takes a controller as an argument and returns a widget.
/// 
/// Args:
///   _locationController: TextEditingController
/// 
/// Returns:
///   A Container widget with a child of a _formField widget.
Widget _location(_locationController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(
      _locationController,
      "Location",
      Icon(Icons.pin_drop),
      false,
      TextInputType.text,
      1,
    ),
  );
}

/// _description is a function that returns a Container widget that contains a _formField widget.
/// 
/// Args:
///   _descriptionController: TextEditingController
/// 
/// Returns:
///   A Container widget with a child of a _formField widget.
Widget _description(_descriptionController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(
      _descriptionController,
      "Description",
      Icon(Icons.note),
      false,
      TextInputType.multiline,
      null,
    ),
  );
}

/// _email is a function that returns a Container widget that contains a _formField widget.
/// 
/// Args:
///   _emailController: The controller for the TextField
/// 
/// Returns:
///   A Container widget with a margin of 5 pixels on all sides.
Widget _email(_emailController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(
      _emailController,
      "Email",
      Icon(Icons.email),
      false,
      TextInputType.emailAddress,
      1,
    ),
  );
}

/// _phone() is a function that returns a Container widget that contains a _formField() widget.
/// 
/// Args:
///   _phoneController: TextEditingController
/// 
/// Returns:
///   A Container widget with a child of a _formField widget.
Widget _phone(_phoneController) {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: _formField(
        _phoneController,
        "Phone Number",
        Icon(Icons.phone_android),
        false,
        TextInputType.phone,
        1,
      ));
}

/// _password() is a function that returns a Container widget that contains a _formField() widget.
/// 
/// Args:
///   _passwordController: The controller for the text field
/// 
/// Returns:
///   A Container widget with a child of a _formField widget.
Widget _password(_passwordController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(
      _passwordController,
      "Password",
      Icon(Icons.lock),
      true,
      TextInputType.visiblePassword,
      1,
    ),
  );
}

/// It returns a TextFormField widget.
/// 
/// Args:
///   _controller: TextEditingController
///   _formLabel: The label of the form field.
///   _prefixIcon: Icon(Icons.email)
///   _obscureText: true/false
///   _textInputType: TextInputType.text,
///   _maxLines: This is the number of lines the text field will have.
/// 
/// Returns:
///   A TextFormField widget.
Widget _formField(
  _controller,
  _formLabel,
  _prefixIcon,
  _obscureText,
  _textInputType,
  _maxLines,
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
    maxLines: _maxLines,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Field can\'t be empty.';
      } else {
        return null;
      }
    },
  );
}

/// It returns a loading indicator widget.
///
/// Returns:
///   A widget.
loading() {
  return const LoadingIndicator(
      indicatorType: Indicator.ballPulseSync,

      /// Required, The loading type of the widget
      colors: [Colors.indigo],

      /// Optional, The color collections
      strokeWidth: 2,

      /// Optional, The stroke of the line, only applicable to widget which contains line
      backgroundColor: Colors.transparent,

      /// Optional, Background of the widget
      pathBackgroundColor: Colors.transparent

      /// Optional, the stroke backgroundColor
      );
}
