import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/account/profile/bloc/profile_bloc.dart';
import 'package:balemoya/job/home/bloc/home_bloc.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// It's a drawer that has a logout button
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A Widget.
Widget drawer({required String pageName, required BuildContext context}) {
  /// It's getting the blocs from the context.
  final homeBloc = BlocProvider.of<HomeBloc>(context);
  final profileBloc = BlocProvider.of<ProfileBloc>(context);

  /// It's a drawer that has a logout button
  return Drawer(
    child: BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is LoggedOut) {
          animatedSnackBar(
            context: context,
            message: "Successfully Logged Out.",
            animatedSnackBarType: AnimatedSnackBarType.info,
          );
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/intro_screen', (route) => false);
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
                    radius: 45,
                    backgroundImage:
                        AssetImage('assets/profile_picture_placeholder.png'),
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
                
                if (pageName == "home") {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home_screen', (route) => false);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Account'),
              onTap: () {
                Navigator.of(context).pushNamed('/profile_screen');
                profileBloc.add(LoadProfileEvent());
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
                    homeBloc.add(LogoutEvent());
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
