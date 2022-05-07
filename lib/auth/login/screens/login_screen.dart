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
          if (state is LoginSuccess) {
            animatedSnackBar(
              context: context,
              message: 'Login Success!',
              animatedSnackBarType: AnimatedSnackBarType.success,
            );
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home_screen', (route) => false);
          }
          // login failure
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
