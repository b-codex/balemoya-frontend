import 'package:balemoya/job/home/screens/employer_home_screen.dart';
import 'package:balemoya/job/home/screens/employee_home_screen.dart';
import 'package:balemoya/static/shared_preference.dart';
import 'package:balemoya/static/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    late String role = "";

    Future<Object> getRole() async {
      final SharedPreference _prefs = SharedPreference();
      final role = await _prefs.getSession().then((value) {
        return value[2];
      });
      return role;
    }

    return FutureBuilder(
      builder: (BuildContext ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final String response = snapshot.data as String;
            role = response;
          }
        }
        if (role == "employee") {
          return employeeScreen(context: context, role: role);
        }
        // else, meaning if it is an employer role
        return employerScreen(context: context, role: role);
      },
      future: getRole(),
    );
  }
}

Widget employeeScreen({required BuildContext context, required String role}) {
  return Scaffold(
    appBar: employeeScreenAppBar(context),
    drawer: drawer(context: context, pageName: "home"),
    body: employeeScreenBody(context, role),
  );
}

Widget employerScreen({required BuildContext context, required String role}) {
  return Scaffold(
    appBar: employerScreenAppBar(context),
    drawer: drawer(context: context, pageName: "home"),
    body: employerScreenBody(context, role),
  );
}
