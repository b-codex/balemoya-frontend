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
  required MobileSnackBarPosition mobileSnackBarPosition,
  required Duration duration,
}) {
  return AnimatedSnackBar.material(
    message,
    type: animatedSnackBarType,
    mobileSnackBarPosition: mobileSnackBarPosition,
    duration: duration,
  ).show(context);
}
