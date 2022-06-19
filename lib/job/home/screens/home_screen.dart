import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/job/home/bloc/home_bloc.dart';
import 'package:balemoya/job/home/screens/employer_home_screen.dart';
import 'package:balemoya/job/home/screens/employee_home_screen.dart';
import 'package:balemoya/static/shared_preference.dart';
import 'package:balemoya/static/widgets/drawer.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final String role;
  const HomeScreen({Key? key, required this.role}) : super(key: key);
  static const routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    // late String role = "";

    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is GetJobPostsFailed) {
          animatedSnackBar(
            context: context,
            message: "An Error Occurred. Please Try Again",
            animatedSnackBarType: AnimatedSnackBarType.error,
          );

          homeBloc.add(GetJobPosts());
        }
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          homeBloc.add(GetJobPosts());
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// Checking if the state is GetJobPostsSuccess. If it is, it will check if the role is an employee. If
        /// it is, it will return the employeeScreen function. If it is not, it will return the employerScreen
        /// function.
        if (state is GetJobPostsSuccess) {
          if (role == "employee") {
            return employeeScreen(
              context: context,
              role: role,
              profilePicture: "profilePicture",
              jobs: state.jobs,
            );
          } else {
            return employerScreen(
              context: context,
              role: role,
              profilePicture: 'profilePicture',
              jobs: state.jobs,
            );
          }
        }

        /// Returning a Scaffold widget with an appBar and a body. The body is a container with an
        /// alignment of center and a button. The button has a text of "Reload" and when it is pressed,
        /// it will call the GetJobPosts function.
        if (state is GetJobPostsFailed) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  homeBloc.add(GetJobPosts());
                },
                child: Text("Reload"),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(),
        );
      },
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
  required String profilePicture,
  required List jobs,
}) {
  return Scaffold(
    appBar: employeeScreenAppBar(context),
    drawer: drawer(
      context: context,
      pageName: "home",
      profilePicture: profilePicture,
      role: role,
    ),
    body: employeeScreenBody(context, role, jobs),
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
  required String profilePicture,
  required List jobs,
}) {
  return Scaffold(
    appBar: employerScreenAppBar(context),
    drawer: drawer(
      context: context,
      pageName: "home",
      role: role,
      profilePicture: profilePicture,
    ),
    body: employerScreenBody(context, role, jobs),
  );
}

/// It gets the role of the user from the shared preferences and returns it
///
/// Args:
///   context: The context of the screen.
///   role (String): The role of the user.
///   fullName (String): The full name of the user.
///
/// Returns:
///   The futureBuilder is being returned.
Widget futureBuilder({
  required context,
  required String role,
  required List jobs,
}) {
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
    // fullName = data[0];
    return role;
  }

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

      /// Checking if the future has data or an error.
      if (snapshot.connectionState == ConnectionState.done) {
        /// Checking if the future has data or an error.
        if (snapshot.hasData) {
          final String response = snapshot.data as String;
          role = response;
        }

        /// Checking if the future has an error. If it does, it will show a snack bar with the message
        /// "An Error Occurred. Please Login Again." and it will navigate to the login screen.
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

      /// Checking if the role of the user is an employee. If it is, it will return the employeeScreen
      /// function.
      if (role == "employee") {
        return employeeScreen(
          context: context,
          role: role,
          profilePicture: "",
          jobs: jobs,
        );
      }

      /// else, meaning if it is an employer role
      return employerScreen(
        context: context,
        role: role,
        profilePicture: "",
        jobs: jobs,
      );
    },
    future: getRole(),
  );
}
