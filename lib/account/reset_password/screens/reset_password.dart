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

PreferredSizeWidget _appBar() {
  return AppBar(
    title: Text("Reset Password"),
    centerTitle: true,
  );
}

Widget _body(context) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _fullNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneNumberController = TextEditingController();

  return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
    listener: (context, state) {
      print(state);
      if (state is PasswordResetSuccess) {
        animatedSnackBar(
          context: context,
          message: "Password Changed Successfully.",
          animatedSnackBarType: AnimatedSnackBarType.success,
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/login",
          (route) => false,
        );
      }

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
              _fullName(_fullNameController),
              _email(_emailController),
              _phone(_phoneNumberController),
              Container(
                margin: EdgeInsets.only(
                  top: 35,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    var _alertDialog = AlertDialog(
                      title: Text('Confirmation'),
                      content: Text(
                          'Your information has been validated. Please check your email for password reset link.\nDon\'t forget to check spam folder.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Ok'),
                        ),
                      ],
                    );
                    if (_formKey.currentState!.validate()) {
                      final resetPasswordBloc =
                          BlocProvider.of<ResetPasswordBloc>(context);

                      resetPasswordBloc.add(
                        PasswordResetRequest(
                          resetPasswordModel: ResetPasswordModel(
                            fullName: _fullNameController.text.trim(),
                            email: _emailController.text.trim(),
                            phoneNumber: _phoneNumberController.text.trim(),
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
