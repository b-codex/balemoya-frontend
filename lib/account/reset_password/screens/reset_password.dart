import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/account/reset_password/bloc/reset_password_bloc.dart';
import 'package:balemoya/account/reset_password/models/models.dart';
import 'package:balemoya/auth/login/screens/login_screen.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

/// _appBar() returns an AppBar widget with a title of "Reset Password" and the title centered
///
/// Returns:
///   A widget that is an AppBar with a title and centerTitle set to true.
PreferredSizeWidget _appBar() {
  return AppBar(
    title: Text("Reset Password"),
    centerTitle: true,
  );
}

/// It's a BlocConsumer that listens to the ResetPasswordBloc and shows a snackbar and an alert dialog
/// when the password reset is successful. It also shows a snackbar when the password reset fails
///
/// Args:
///   context: The BuildContext of the widget.
///
/// Returns:
///   A BlocConsumer widget.
Widget _body(context) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  var _fullNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var _securityQuestionController1 = TextEditingController();
  var _securityQuestionController2 = TextEditingController();
  var _securityQuestionController3 = TextEditingController();
  var _newPasswordController = TextEditingController();

  return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
    listener: (context, state) {
      /// Showing a snackbar and an alert dialog when the password reset is successful.
      if (state is PasswordResetSuccess) {
        animatedSnackBar(
          context: context,
          message: "Your Password has been reset successfully",
          animatedSnackBarType: AnimatedSnackBarType.success,
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false,
        );
        // var _alertDialog = AlertDialog(
        //   title: Text('Your New Password?'),
        //   content: Form(
        //     key: _formKey2,
        //     child: _formField(
        //       _newPasswordController,
        //       "New Password",
        //       Icon(Icons.security),
        //       TextInputType.text,
        //     ),
        //   ),
        //   actions: [
        //     TextButton(
        //       onPressed: () {
        //         if (_formKey2.currentState!.validate()) {}
        //         Navigator.of(context).pushNamedAndRemoveUntil(
        //           "/login",
        //           (route) => false,
        //         );
        //       },
        //       child: Text('Ok'),
        //     ),
        //   ],
        // );
        // showDialog(
        //   context: context,
        //   builder: (BuildContext ctx) {
        //     return _alertDialog;
        //   },
        // );
      }

      /// Showing a snackbar when the password reset fails.
      if (state is PasswordResetFailed) {
        animatedSnackBar(
          context: context,
          message: "Task Failed. Please Try Again.",
          animatedSnackBarType: AnimatedSnackBarType.error,
        );
      }
    },
    builder: (context, state) {
      return Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Row(
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
              ),

              /// It's a function that returns a Container widget that contains a _formField widget
              _fullName(_fullNameController),
              _email(_emailController),
              _phone(_phoneNumberController),
              _newPassword(_newPasswordController),
              _securityQuestion1(_securityQuestionController1),
              _securityQuestion2(_securityQuestionController2),
              _securityQuestion3(_securityQuestionController3),
              Container(
                margin: EdgeInsets.only(
                  top: 35,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    /// Validating the form and if the form is valid, it is adding a
                    /// PasswordResetRequest event to the ResetPasswordBloc.
                    if (_formKey.currentState!.validate()) {
                      final resetPasswordBloc =
                          BlocProvider.of<ResetPasswordBloc>(context);

                      resetPasswordBloc.add(
                        PasswordResetRequest(
                          resetPasswordModel: ResetPasswordModel(
                            fullName: _fullNameController.text.trim(),
                            email: _emailController.text.trim(),
                            phoneNumber: _phoneNumberController.text.trim(),
                            securityQuestion1:
                                _securityQuestionController1.text.trim(),
                            securityQuestion2:
                                _securityQuestionController2.text.trim(),
                            securityQuestion3:
                                _securityQuestionController3.text.trim(),
                            newPassword: _newPasswordController.text.trim(),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(400, 50),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

/// _fullName is a function that returns a Container widget that contains a _formField widget
///
/// Args:
///   _fullNameController: The controller for the text field.
///
/// Returns:
///   A Container widget with a child of a _formField widget.
Widget _fullName(_fullNameController) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: _formField(
      _fullNameController,
      "Fullname",
      Icon(Icons.person),
      TextInputType.name,
    ),
  );
}

/// _email is a function that returns a Container widget that contains a _formField widget
///
/// Args:
///   _emailController: The controller for the email field
///
/// Returns:
///   A Container widget with a margin and a child widget.
Widget _email(_emailController) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: _formField(
      _emailController,
      "Email",
      Icon(Icons.alternate_email),
      TextInputType.emailAddress,
    ),
  );
}

/// _phone() is a function that returns a Container widget that contains a _formField() widget
///
/// Args:
///   _phoneNumberController: TextEditingController
///
/// Returns:
///   A Container widget with a margin of 5 pixels on the top and bottom and 10 pixels on the left and
/// right. The child of the Container is a _formField widget.
Widget _phone(_phoneNumberController) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: _formField(
      _phoneNumberController,
      "Phone Number",
      Icon(Icons.phone),
      TextInputType.phone,
    ),
  );
}

Widget _newPassword(_newPasswordController) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: _formField(
      _newPasswordController,
      "New Password",
      Icon(Icons.security),
      TextInputType.visiblePassword,
    ),
  );
}

Widget _securityQuestion1(_securityQuestion1Controller) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: _formField(
      _securityQuestion1Controller,
      "Favorite Place",
      Icon(Icons.question_answer),
      TextInputType.text,
    ),
  );
}

Widget _securityQuestion2(_securityQuestion2Controller) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: _formField(
      _securityQuestion2Controller,
      "Childhood Memory",
      Icon(Icons.question_answer),
      TextInputType.text,
    ),
  );
}

Widget _securityQuestion3(_securityQuestion3Controller) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: _formField(
      _securityQuestion3Controller,
      "Mother's Maiden Name",
      Icon(Icons.question_answer),
      TextInputType.text,
    ),
  );
}

/// _formField() is a function that returns a TextFormField widget
///
/// Args:
///   _controller: TextEditingController
///   _formLabel: The label of the form field.
///   _prefixIcon: Icon(Icons.person)
///   _type: TextInputType.number
///
/// Returns:
///   A TextFormField widget.
Widget _formField(_controller, _formLabel, _prefixIcon, _type) {
  return TextFormField(
    controller: _controller,
    decoration: InputDecoration(
      label: Text("$_formLabel"),
      prefixIcon: _prefixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    keyboardType: _type,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Field can\'t be empty.';
      } else {
        return null;
      }
    },
  );
}
