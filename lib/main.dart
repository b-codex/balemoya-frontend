import 'package:BaleMoya/auth/register/screens/register_screen.dart';
import 'package:BaleMoya/intro_screen.dart';
import 'package:BaleMoya/job/home/home_screen.dart';
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
        '/home' : (context) => const HomeScreen(),
      },
    );
  }
}
