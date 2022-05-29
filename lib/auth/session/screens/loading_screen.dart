import 'package:balemoya/auth/session/bloc/user_session_bloc.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

/// The LoadingScreen class is a stateless widget that is the first screen to be displayed when the app
/// is launched. It checks if the user has a session and if they do, it navigates to the home screen. If
/// they don't, it navigates to the login screen
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  /// A static variable that is used to define the route name for the loading screen.
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    /// Getting the bloc from the context.
    final bloc = BlocProvider.of<UserSessionBloc>(context);

    /// A BlocConsumer that is listening to the UserSessionBloc and UserSessionState.
    return Scaffold(
      body: BlocConsumer<UserSessionBloc, UserSessionState>(
        /// Listening to the UserSessionBloc and UserSessionState.
        listener: (context, state) async {
          if (state is UserSessionFound) {
            /// A function that is defined in the snack_bar.dart file. It is used to display a snackbar
            /// with an animation.
            animatedSnackBar(
              context: context,
              message: 'User Session Found',
              animatedSnackBarType: AnimatedSnackBarType.success,
            );

            /// Navigating to the home screen and removing all the routes that are in the stack.
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home_screen', (route) => false);
          }

          /// Checking if the user session is not found and if it is not found, it displays a snackbar
          /// and navigates to the login screen.
          if (state is UserSessionNotFound) {
            animatedSnackBar(
              context: context,
              message: 'User Session Not Found',
              animatedSnackBarType: AnimatedSnackBarType.error,
            );

            Navigator.of(context).pushNamedAndRemoveUntil(
              '/intro_screen',
              (route) => false,
            );
          }
        },

        /// Checking if the state is UserSessionInitial and if it is, it is adding the
        /// CheckUserSessionEvent to the bloc.
        builder: (context, state) {
          /// Checking if the state is UserSessionInitial and if it is, it is adding the
          /// CheckUserSessionEvent to the bloc.
          if (state is UserSessionInitial) {
            bloc.add(CheckUserSessionEvent());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
