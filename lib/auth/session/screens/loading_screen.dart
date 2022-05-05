import 'package:balemoya/auth/session/bloc/user_session_bloc.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  static const routeName = "/loading_screen";

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserSessionBloc>(context);
    return Scaffold(
      body: BlocConsumer<UserSessionBloc, UserSessionState>(
        listener: (context, state) async {
          if (state is UserSessionFound) {
            animatedSnackBar(
              context: context,
              message: 'User Session Found',
              animatedSnackBarType: AnimatedSnackBarType.success,
            );
            Navigator.of(context).pushNamedAndRemoveUntil('/home_screen', (route) => false);
          }

          if (state is UserSessionNotFound) {
            animatedSnackBar(
              context: context,
              message: 'User Session Not Found',
              animatedSnackBarType: AnimatedSnackBarType.error,
            );

            Navigator.of(context).pushNamedAndRemoveUntil(
              '/',
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          print(state);
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
