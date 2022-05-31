import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/job/home/screens/employer_home_screen.dart';
import 'package:balemoya/job/home/screens/employee_home_screen.dart';
import 'package:balemoya/static/shared_preference.dart';
import 'package:balemoya/static/widgets/drawer.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    late String role = "";
    late String fullName = "";

    /// It gets the role of the user from the shared preferences and returns it
    ///
    /// Returns:
    ///   The role of the user.
    Future<Object> getRole() async {
      final SharedPreference _prefs = SharedPreference();
      final data = await _prefs.getSession().then((value) {
        return value;
      });
      role = data[2];
      fullName = data[0];
      return role;
    }

    /// A FutureBuilder widget that is used to build widgets based on the future result.
    return FutureBuilder(
      builder: (BuildContext ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final String response = snapshot.data as String;
            role = response;
          }
          if (snapshot.hasError) {
            animatedSnackBar(
              context: context,
              message: "An Error Occurred. Please Login Again.",
              animatedSnackBarType: AnimatedSnackBarType.error,
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              'login',
              (route) => false,
            );
          }
        }
        if (role == "employee") {
          return employeeScreen(
            context: context,
            role: role,
            fullName: fullName,
            profilePicture: "",
          );
        }
        // else, meaning if it is an employer role
        return employerScreen(
          context: context,
          role: role,
          fullName: fullName,
          profilePicture: "",
        );
      },
      future: getRole(),
    );
  }
}

/// This function returns a Scaffold widget with an appBar, a drawer, and a body.
///
/// Args:
///   context (BuildContext): The context of the screen.
///   role (String): The role of the user.
///
/// Returns:
///   A Scaffold widget with an appBar, drawer, and body.
Widget employeeScreen({
  required BuildContext context,
  required String role,
  required String fullName,
  required String profilePicture,
}) {
  return Scaffold(
    appBar: employeeScreenAppBar(context),
    drawer: drawer(
      context: context,
      pageName: "home",
      fullName: fullName,
      profilePicture: profilePicture,
      role: role,
    ),
    body: employeeScreenBody(context, role),
  );
}

/// This function returns a Scaffold widget with an appBar, a drawer, and a body.
///
/// Args:
///   context (BuildContext): The context of the screen.
///   role (String): The role of the user.
///
/// Returns:
///   A Scaffold widget with an appBar, drawer, and body.
Widget employerScreen({
  required BuildContext context,
  required String role,
  required String fullName,
  required String profilePicture,
}) {
  return Scaffold(
    appBar: employerScreenAppBar(context),
    drawer: drawer(
      context: context,
      pageName: "home",
      fullName: fullName,
      role: role,
      profilePicture: profilePicture,
    ),
    body: employerScreenBody(context, role, fullName),
  );
}
