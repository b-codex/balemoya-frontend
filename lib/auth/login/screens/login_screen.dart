import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/auth/login/bloc/login_bloc.dart';
import 'package:balemoya/auth/login/models/model.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();

    /// Getting the LoginBloc from the BlocProvider.
    final bloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("BaleMoya"),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          // login success
          /// Checking if the login is successful and then it is checking the role of the user and then
          /// it is navigating to the home screen.
          if (state is LoginSuccess) {
            animatedSnackBar(
              context: context,
              message: 'Login Success!',
              animatedSnackBarType: AnimatedSnackBarType.success,
            );

            if (state.role == "employee") {}
            if (state.role == "employer") {}

            
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/home_screen', (route) => false,
                arguments: {
                  "role": state.role,
                });
          }
          // login failure
          /// Showing a snackbar when the login fails.
          if (state is LoginFailed) {
            animatedSnackBar(
              context: context,
              message: 'Login Failed!',
              animatedSnackBarType: AnimatedSnackBarType.error,
            );
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
                      _loginImageAndText(),
                      _email(_emailController),
                      _password(_passwordController),
                      BlocBuilder<LoginBloc, LoginState>(
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
                                child: loading(),
                                onPressed: null,
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
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  bloc.add(
                                    AttemptLogin(
                                      loginModel: LoginModel(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        }),
                      ),
                      _dontHaveAnAccountButton(context),
                      _resetAccountButton(context),
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

/// _loginImageAndText() returns a Container that contains a Column that contains a Container that
/// contains an Image and a Text.
/// 
/// Returns:
///   A widget that is a container with a column inside of it.
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

/// _email is a function that takes a controller as an argument and returns a widget.
/// 
/// Args:
///   _emailController: TextEditingController
/// 
/// Returns:
///   A Container widget with a margin of 5 pixels on all sides.
Widget _email(_emailController) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: _formField(
      _emailController,
      "Email",
      Icon(Icons.alternate_email),
      false,
    ),
  );
}

/// _password() is a function that returns a Container widget that contains a _formField() widget.
/// 
/// Args:
///   _passwordController: TextEditingController
/// 
/// Returns:
///   A Container widget with a margin of 5 pixels on all sides.
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

/// _dontHaveAnAccountButton() is a function that returns a Container widget that contains a TextButton
/// widget that contains a Text widget that contains the text 'Don\'t Have An Account?'.
/// 
/// Args:
///   context: The context of the widget.
/// 
/// Returns:
///   A Container widget with a TextButton widget as a child.
Widget _dontHaveAnAccountButton(context) {
  return Container(
    margin: EdgeInsets.only(
      top: 7,
    ),
    padding: EdgeInsets.all(3),
    child: TextButton(
      onPressed: () => Navigator.pushNamed(context, '/register'),
      child: Text(
        'Don\'t Have An Account?',
      ),
    ),
  );
}

/// _resetAccountButton() is a function that returns a Container widget that contains a TextButton
/// widget that has a child Text widget that has a String value of 'Forgot Password?' and when pressed,
/// navigates to the '/reset_password' route.
/// 
/// Args:
///   context: The context of the widget.
/// 
/// Returns:
///   A Container widget with a TextButton widget as a child.
Widget _resetAccountButton(context) {
  return Container(
    // margin: EdgeInsets.all(7),
    padding: EdgeInsets.all(3),
    child: TextButton(
      onPressed: () => Navigator.pushNamed(context, '/reset_password'),
      child: Text(
        'Forgot Password?',
      ),
    ),
  );
}

/// _formField() is a function that returns a TextFormField widget.
/// 
/// Args:
///   _controller: TextEditingController
///   _formLabel: The label of the form field.
///   _prefixIcon: Icon(Icons.email)
///   _obscureText: bool
/// 
/// Returns:
///   A TextFormField widget.
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

/// It returns a LoadingIndicator widget.
/// 
/// Returns:
///   A widget that is a loading indicator.
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
