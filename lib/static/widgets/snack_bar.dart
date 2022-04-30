import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

SnackBar createSnackBar({
  required String content,
  required Color backgroundColor,
  required Duration duration,
}) {
  return SnackBar(
    content: Text(
      content,
      textAlign: TextAlign.center,
    ),
    backgroundColor: backgroundColor,
    duration: duration,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
  );
}

showSnackBar({
  required context,
  required SnackBar snackBar,
}) {
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

animatedSnackBar({
  required context,
  required String message,
  required AnimatedSnackBarType animatedSnackBarType,
}) {
  return AnimatedSnackBar.material(
    message,
    type: animatedSnackBarType,
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    duration: Duration(seconds: 5),
  ).show(context);
}