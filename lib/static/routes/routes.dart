import 'package:balemoya/account/employeeProfileView/screens/employee_profile_view.dart';
import 'package:balemoya/account/profile/screens/profile_screen.dart';
import 'package:balemoya/account/reset_password/screens/reset_password.dart';
import 'package:balemoya/auth/login/screens/login_screen.dart';
import 'package:balemoya/auth/register/screens/register_screen.dart';
import 'package:balemoya/job/bookmarks/screens/bookmarks.dart';
import 'package:balemoya/job/home/screens/home_screen.dart';
import 'package:balemoya/job/job_detail/screens/job_detail.dart';
import 'package:balemoya/job/create_job_post/screens/create_job_post.dart';
import 'package:balemoya/job/search_results/screens/search_results.dart';
import 'package:balemoya/static/screens/intro_screen.dart';
import 'package:balemoya/auth/session/screens/loading_screen.dart';
import 'package:flutter/material.dart';

/// It's a class that contains all the routes of the app and it's used to navigate between them
class RouteManager {
  static const String loading_screen = '/';
  static const String intro_screen = '/intro_screen';
  static const String login = '/login';
  static const String register = '/register';
  static const String home_screen = '/home_screen';
  static const String bookmarks = '/bookmarks';
  static const String job_detail = '/job_detail';
  static const String create_job_post = '/create_job_post';
  static const String profile_screen = '/profile_screen';
  static const String reset_password = '/reset_password';
  static const String search_results = '/search_results';
  static const String employee_profile_view = '/employee_profile_view';
  static const String employer_profile_view = '/employer_profile_screen';

  /// It takes a RouteSettings object as an argument and returns a Route object
  ///
  /// Args:
  ///   settings (RouteSettings): RouteSettings
  ///
  /// Returns:
  ///   A MaterialPageRoute with a builder function that returns a widget.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    late var values;

    /// It's checking if the route has arguments or not.
    if (settings.arguments != null) {
      values = settings.arguments as Map<String, dynamic>;
    }
    if (settings.arguments == null) {}

    /// It's a switch statement that checks the value of settings.name and returns a MaterialPageRoute
    /// with a builder function that returns a widget.
    switch (settings.name) {
      case intro_screen:
        return MaterialPageRoute(
          builder: (context) => IntroScreen(),
        );

      case login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );

      case register:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );

      case home_screen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(
            role: values['role'],
          ),
        );

      case loading_screen:
        return MaterialPageRoute(
          builder: (context) => LoadingScreen(),
        );

      case bookmarks:
        return MaterialPageRoute(
          builder: (context) => Bookmarks(),
        );

      case job_detail:
        return MaterialPageRoute(
          builder: (context) => JobDetail(job: values),
        );

      case create_job_post:
        return MaterialPageRoute(
          builder: (context) => CreateJobPost(),
        );

      case profile_screen:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        );

      case reset_password:
        return MaterialPageRoute(
          builder: (context) => ResetPassword(),
        );

      case search_results:
        return MaterialPageRoute(
          builder: (context) => SearchResults(),
        );

      case employee_profile_view:
        return MaterialPageRoute(
          builder: (context) => EmployeeProfileView(),
        );

      // case employer_profile_screen:
      //   return MaterialPageRoute(
      //     builder: (context) => EmployerProfileView(),
      //   );

      // case favZoomedImage:
      //   return MaterialPageRoute(
      //     builder: (context) => FavZoomedImageScreen(
      //       imageURL: values['imageURL'],
      //     ),
      //   );
      default:
        throw FormatException('Route Not Found!');
    }
  }
}
