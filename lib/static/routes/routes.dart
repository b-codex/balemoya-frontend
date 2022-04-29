import 'package:balemoya/account/profile/screens/profile_screen.dart';
import 'package:balemoya/account/reset_password/screens/reset_password.dart';
import 'package:balemoya/auth/login/screens/login_screen.dart';
import 'package:balemoya/auth/register/screens/register_screen.dart';
import 'package:balemoya/job/bookmarks/screens/bookmarks.dart';
import 'package:balemoya/job/home/screens/home_screen.dart';
import 'package:balemoya/job/job_detail/screens/job_detail.dart';
import 'package:balemoya/job/job_post/screens/create_job_post.dart';
import 'package:balemoya/job/search_results/screens/search_results.dart';
import 'package:balemoya/static/screens/intro_screen.dart';
import 'package:balemoya/auth/session/screens/loading_screen.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static const String intro_screen = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home_screen = '/home_screen';
  static const String loading_screen = '/loading_screen';
  static const String bookmarks = '/bookmarks';
  static const String job_detail = '/job_detail';
  static const String create_job_post = '/create_job_post';
  static const String profile_screen = '/profile_screen';
  static const String reset_password = '/reset_password';
  static const String search_results = '/search_results';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    late var values;

    if (settings.arguments != null) {
      values = settings.arguments as Map<String, dynamic>;
    }

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
          builder: (context) => HomeScreen(),
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
          builder: (context) => JobDetail(),
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
