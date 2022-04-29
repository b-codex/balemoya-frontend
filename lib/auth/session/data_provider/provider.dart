import 'package:balemoya/job/home/screens/home_screen.dart';
import 'package:balemoya/static/shared_preference.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class SessionProvider {
  Future<bool> checkUserSession() async {
    bool status = false;
    final sharedPreferences = SharedPreference();

    // getting session id from shared preference
    sharedPreferences.getSession().then(
      (value) {
        // if there exists a value, the status == true (meaning there is a user session)
        status = true;
      },
    );
    // if a value isn't found, status == false (meaning there is no user session)
    return status;
  }

  // on login
  Future<Object> saveUserSession(sessionInfo) async {
    final sharedPreferences = SharedPreference();

    // saving session
    var response = await sharedPreferences.saveSession(name: '', sessionID: '');
    return response;
  }
}

_checkingUserSession(context) {
  // checking if the user has already logged in
  bool status = false;
  final sharedPreferences = SharedPreference();

  // getting session id from shared preference
  sharedPreferences.getSession().then(
    (value) {
      status = true;
    },
  );

  // if the user is logged in
  if (status) {
    var snackBar = createSnackBar(
      content: 'Logged in as: some user',
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    );

    showSnackBar(context: context, snackBar: snackBar);

    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
    print(status);
  }

  //if the user isn't logged in

  // var snackBar = createSnackBar(
  //   content: 'Not logged in',
  //   backgroundColor: Colors.red,
  //   duration: Duration(seconds: 1),
  // );

  // showSnackBar(context: context, snackBar: snackBar);

  // Navigator.pushReplacement<void, void>(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => IntroScreen(),
  //   ),
  // );
  print(status);
}
