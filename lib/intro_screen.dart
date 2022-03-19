import 'package:balemoya/auth/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'BaleMoya',
              body: 'tagline',
              image: buildImage('assets/manthumbs.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Find Jobs With Ease',
              body: 'The jobs can be one-time, part-time or full-time',
              image: buildImage('assets/manthumbs.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Organization',
              body: 'As an organization, you can create or delete job posts and look for qualified employees',
              image: buildImage('assets/manthumbs.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Individual',
              body: 'As an individual, you can upload your CV and search for jobs of your preference',
              image: buildImage('assets/manthumbs.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Notifications',
              body: 'Get notified when jobs are available in your area',
              image: buildImage('assets/manthumbs.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Verification',
              body:
                  'Increase your chances of being found by verifying your account',
              image: buildImage('assets/manthumbs.png'),
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
              image: buildImage('assets/manthumbs.png'),
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
          skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  void gotoLogin(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
