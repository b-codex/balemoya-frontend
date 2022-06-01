import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

/// This function takes in a required content, backgroundColor, and duration, and returns a SnackBar
/// with the content, backgroundColor, and duration
///
/// Args:
///   content (String): The text that will be displayed in the snackbar.
///   backgroundColor (Color): The background color of the snackbar.
///   duration (Duration): The duration of the snackbar.
///
/// Returns:
///   A SnackBar
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

/// It takes a context and a snackbar, and shows the snackbar
///
/// Args:
///   context: The BuildContext of the widget that you want to show a snackbar on.
///   snackBar (SnackBar): The SnackBar to show.
showSnackBar({
  required context,
  required SnackBar snackBar,
}) {
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// It shows a snackbar with the message and the type of snackbar.
///
/// Args:
///   context: The context of the widget that is calling the snackbar.
///   message (String): The message you want to display.
///   animatedSnackBarType (AnimatedSnackBarType): This is the type of the snackbar. It can be either
/// success, error, warning, or info.
///
/// Returns:
///   A Future&lt;void&gt;
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
