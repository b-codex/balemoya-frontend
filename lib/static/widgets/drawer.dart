import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/job/home/bloc/home_bloc.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: unused_element
Widget drawer(context) {
  final bloc = BlocProvider.of<HomeBloc>(context);
  return Drawer(
    child: BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        //
        if (state is LoggedOut) {
          // Navigator.of(context).pushReplacementNamed('/');
          animatedSnackBar(
            context: context,
            message: "Successfully Logged Out.",
            animatedSnackBarType: AnimatedSnackBarType.info,
          );
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
        if (state is LoggingOutFailed) {
          animatedSnackBar(
            context: context,
            message: 'Logging Out Failed.',
            animatedSnackBarType: AnimatedSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    minRadius: 50,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      'assets/google.jpg',
                      width: 100,
                    ),
                  ),
                  Text(
                    'User',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Navigator.of(context).pushNamed('/home');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Account'),
              onTap: () {
                Navigator.of(context).pushNamed('/profile_screen');
                // bloc.add(AccountButtonClick());
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Bookmarks'),
              onTap: () {
                Navigator.of(context).pushNamed('/bookmarks');
              },
            ),
            ListTile(
              // leading: Icon(Icons.bookmark),
              title: Text('Create Job Post'),
              onTap: () {
                Navigator.of(context).pushNamed('/create_job_post');
              },
            ),
            ListTile(
              // leading: Icon(Icons.bookmark),
              title: Text('Search Results'),
              onTap: () {
                Navigator.of(context).pushNamed('/search_results');
              },
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    bloc.add(LogoutEvent());
                  },
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}
