import 'package:balemoya/auth/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

/// It's a stateless widget that displays a list of pages to the user
class IntroScreen extends StatelessWidget {
  /// A static variable that is used to identify the route.
  static const routeName = "/intro_screen";

  @override
  Widget build(BuildContext context) => SafeArea(
        /// A widget that displays a list of pages to the user.
        child: IntroductionScreen(
          pages: [
            /// Creating a list of pages to be displayed to the user.
            PageViewModel(
              title: 'BaleMoya',
              body: 'Find The Right Person For The Right Job',
              image: buildImage('assets/start_screen.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Find Jobs With Ease',
              body: 'The jobs can be one-time, part-time or full-time',
              image: buildImage('assets/find_jobs_with_ease.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Organization',
              body:
                  'As an organization, you can create or delete job posts and look for qualified employees',
              image: buildImage('assets/organization.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Individual',
              body:
                  'As an individual, you can upload your CV and search for jobs of your preference',
              image: buildImage('assets/individual.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Notifications',
              body: 'Get notified when jobs are available in your area',
              image: buildImage('assets/notification.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Verification',
              body:
                  'Increase your chances of being found by verifying your account',
              image: buildImage('assets/verified.png'),
              decoration: getPageDecoration(),
            ),
            // PageViewModel(
            //   title: 'Simple UI',
            //   body: 'For enhanced reading experience',
            //   image: buildImage('assets/manthumbs.png'),
            //   decoration: getPageDecoration(),
            // ),
            PageViewModel(
              title: 'Start Using It Now',
              body:
                  'Go ahead to the login page if you have an account or register to use the system.',
              // footer: ButtonWidget(
              //   text: 'Start Reading',
              //   onClicked: () => gotoLogin(context),
              // ),
              image: buildImage('assets/start_using_now.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Proceed To Login',
              style: TextStyle(fontWeight: FontWeight.w600)),
          onDone: () => gotoLogin(context),
          showSkipButton: true,
          skip: Text('Skip'),
          // onSkip: () => gotoLogin(context),
          next: Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(),
          // onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Colors.white,
          // skipFlex: 0,
          dotsFlex: 4,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          animationDuration: 400,
        ),
      );

  /// It navigates to the login page and removes all the routes from the stack.
  ///
  /// Args:
  ///   context: The context of the current screen.
  void gotoLogin(context) => Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );

/// It returns a widget that displays an image.
/// 
/// Args:
///   path (String): The path to the image file.
  Widget buildImage(String path) => Center(
        child: Image.asset(
          path,
          width: 350,
        ),
      );

/// It returns a DotsDecorator object.
  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

/// A function that returns a PageDecoration object.
  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        // footerPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        // titlePadding: EdgeInsets.all(16).copyWith(bottom: 0),
        bodyPadding: EdgeInsets.all(16).copyWith(bottom: 0),

        // descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
