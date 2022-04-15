import 'package:balemoya/account/profile/screens/profile_screen.dart';
import 'package:balemoya/auth/login/screens/login_screen.dart';
import 'package:balemoya/auth/register/screens/register_screen.dart';
import 'package:balemoya/intro_screen.dart';
import 'package:balemoya/job/bookmarks/screens/bookmarks.dart';
import 'package:balemoya/job/home/screens/home_screen.dart';
import 'package:balemoya/job/job_detail/screens/job_detail.dart';
import 'package:balemoya/job/job_post/screens/create_job_post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BaleMoya',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
      routes: {
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/bookmarks': (context) => const Bookmarks(),
        '/job_detail': (context) => const JobDetail(),
        '/create_job_post': (context) => const CreateJobPost(),
        '/profile_screen': (context) => const ProfileScreen(),
      },
    );
  }
}
