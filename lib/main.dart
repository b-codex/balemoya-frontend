import 'package:balemoya/account/employeeProfileView/bloc/employee_profile_view_bloc.dart';
import 'package:balemoya/account/employeeProfileView/data_provider/provider.dart';
import 'package:balemoya/account/employeeProfileView/repository/repository.dart';
import 'package:balemoya/account/profile/bloc/profile_bloc.dart';
import 'package:balemoya/account/profile/data_provider/provider.dart';
import 'package:balemoya/account/profile/repository/repository.dart';
import 'package:balemoya/account/profile/screens/profile_screen.dart';
import 'package:balemoya/auth/login/bloc/login_bloc.dart';
import 'package:balemoya/auth/login/data_provider/provider.dart';
import 'package:balemoya/auth/login/repository/repository.dart';
import 'package:balemoya/auth/register/bloc/register_bloc.dart';
import 'package:balemoya/auth/register/data_provider/provider.dart';
import 'package:balemoya/auth/register/repository/repository.dart';
import 'package:balemoya/auth/session/bloc/user_session_bloc.dart';
import 'package:balemoya/auth/session/data_provider/provider.dart';
import 'package:balemoya/auth/session/repository/repository.dart';
import 'package:balemoya/auth/session/screens/loading_screen.dart';
import 'package:balemoya/job/home/bloc/home_bloc.dart';
import 'package:balemoya/job/home/data_provider/provider.dart';
import 'package:balemoya/job/home/repository/repository.dart';
import 'package:balemoya/static/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

/// The `main()` function is the entry point of the app
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // session repository
  final SessionRepository sessionRepository = SessionRepository(
    sessionProvider: SessionProvider(),
  );

  // login repository
  final LoginRepository loginRepository = LoginRepository(
    loginProvider: LoginProvider(),
  );

  // register repository
  final RegisterRepository registerRepository = RegisterRepository(
    registerProvider: RegisterProvider(),
  );

  // home repository
  final HomeRepository homeRepository = HomeRepository(
    homeProvider: HomeProvider(),
  );

  // profile repository
  final ProfileRepository profileRepository = ProfileRepository(
    profileProvider: ProfileProvider(),
  );

  // employee profile view repository
  final EmployeeProfileViewRepository employeeProfileViewRepository =
      EmployeeProfileViewRepository(
    employeeProfileViewProvider: EmployeeProfileViewProvider(),
  );

  @override

  /// A function that returns a widget.
  ///
  /// Args:
  ///   context (BuildContext): The current context of the widget.
  Widget build(BuildContext context) {
    /// Creating a MultiBlocProvider with a list of BlocProviders.
    return MultiBlocProvider(
      providers: [
        /// Creating a new instance of the `UserSessionBloc` and passing the `sessionRepository` to it.
        BlocProvider(
          create: (ctx) => UserSessionBloc(
            sessionRepository: sessionRepository,
          ),
        ),

        /// Creating a new instance of the `LoginBloc` and passing the `loginRepository` to it.
        BlocProvider(
          create: (ctx) => LoginBloc(
            loginRepository: loginRepository,
          ),
        ),

        /// Creating a new instance of the `RegisterBloc` and passing the `registerRepository` to it.
        BlocProvider(
          create: (ctx) => RegisterBloc(
            registerRepository: registerRepository,
          ),
        ),

        /// Creating a new instance of the `HomeBloc` and passing the `homeRepository` to it.
        BlocProvider(
          create: (ctx) => HomeBloc(
            homeRepository: homeRepository,
          ),
        ),

        /// Creating a new instance of the `ProfileBloc` and passing the `profileRepository` to it.
        BlocProvider(
          create: (ctx) => ProfileBloc(
            profileRepository: profileRepository,
          ),
        ),

        /// Creating a new instance of the `EmployeeProfileViewBloc` and passing the
        /// `employeeProfileViewRepository` to it.
        BlocProvider(
          create: (ctx) => EmployeeProfileViewBloc(
            employeeProfileViewRepository: employeeProfileViewRepository,
          ),
        ),
      ],

      /// A provider that provides the `sessionRepository` to the `MaterialApp` widget.
      child: RepositoryProvider.value(
        value: sessionRepository,
        child: MaterialApp(
          title: 'BaleMoya',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            textTheme: GoogleFonts.montserratTextTheme(),
          ),
          debugShowCheckedModeBanner: false,
          // home: ProfileScreen(),
          initialRoute: RouteManager.loading_screen,
          onGenerateRoute: RouteManager.generateRoute,
        ),
      ),
    );
  }
}
