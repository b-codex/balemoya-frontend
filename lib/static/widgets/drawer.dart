import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/account/profile/bloc/profile_bloc.dart';
import 'package:balemoya/job/home/bloc/home_bloc.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// It's a drawer that has a logout button
/// 
/// Args:
///   pageName (String): It's the name of the current page.
///   context (BuildContext): It's the context of the screen.
///   fullName (String): It's the name of the user.
///   role (String): It's the role of the user.
///   profilePicture (String): It's the profile picture of the user.
/// 
/// Returns:
///   A Widget.
Widget drawer({
  required String pageName,
  required BuildContext context,
  required String fullName,
  String role = "",
  required String profilePicture,
}) {
  /// It's getting the blocs from the context.
  final homeBloc = BlocProvider.of<HomeBloc>(context);
  final profileBloc = BlocProvider.of<ProfileBloc>(context);

  /// It's a drawer that has a logout button
  return Drawer(
    child: BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        /// It's showing a snackbar and then navigating to the intro screen.
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
                    backgroundImage: AssetImage(
                      'assets/profile_picture_placeholder.png',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$fullName',
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
                    '/home_screen',
                    (route) => false,
                  );
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
            // ListTile(
            //   leading: Icon(Icons.bookmark),
            //   title: Text('Bookmarks'),
            //   onTap: () {
            //     Navigator.of(context).pushNamed('/bookmarks');
            //   },
            // ),
            (() {
              if (role == "employer") {
                return ListTile(
                  leading: Icon(Icons.post_add),
                  title: Text('Create Job Post'),
                  onTap: () {
                    Navigator.of(context).pushNamed('/create_job_post');
                  },
                );
              }
              return SizedBox();
            }()),
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
