import 'dart:math';

import 'package:balemoya/auth/login/screens/login_screen.dart';
import 'package:balemoya/chat/bloc/chat_bloc.dart';
import 'package:balemoya/chat/provider/provider.dart';
import 'package:balemoya/chat/repository/repository.dart';
import 'package:balemoya/static/screens/intro_screen.dart';
import 'package:flutter/material.dart';

import 'package:balemoya/account/employeeProfileView/bloc/employee_profile_view_bloc.dart';
import 'package:balemoya/account/employeeProfileView/data_provider/provider.dart';
import 'package:balemoya/account/employeeProfileView/repository/repository.dart';
import 'package:balemoya/account/profile/bloc/profile_bloc.dart';
import 'package:balemoya/account/profile/data_provider/provider.dart';
import 'package:balemoya/account/profile/repository/repository.dart';
import 'package:balemoya/account/reset_password/bloc/reset_password_bloc.dart';
import 'package:balemoya/account/reset_password/data_provider/provider.dart';
import 'package:balemoya/account/reset_password/repository/repository.dart';
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
import 'package:balemoya/job/create_job_post/bloc/create_job_post_bloc.dart';
import 'package:balemoya/job/create_job_post/data_provider/provider.dart';
import 'package:balemoya/job/create_job_post/repository/repository.dart';
import 'package:balemoya/job/home/bloc/home_bloc.dart';
import 'package:balemoya/job/home/data_provider/provider.dart';
import 'package:balemoya/job/home/repository/repository.dart';
import 'package:balemoya/job/job_detail/bloc/job_detail_bloc.dart';
import 'package:balemoya/job/job_detail/data_provider/provider.dart';
import 'package:balemoya/job/job_detail/repository/repository.dart';
import 'package:balemoya/static/classes/socket.dart';
import 'package:balemoya/static/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

/// The `main()` function is the entry point of the app
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
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

  /// Creating a new instance of the `ResetPasswordRepository` and passing the `resetPasswordProvider` to
  /// it.
  final ResetPasswordRepository resetPasswordRepository =
      ResetPasswordRepository(
    resetPasswordProvider: ResetPasswordProvider(),
  );

  /// Creating a new instance of the `CreateJobPostRepository` and passing the `createJobPostProvider`
  /// to it.
  final CreateJobPostRepository createJobPostRepository =
      CreateJobPostRepository(
    createJobPostProvider: CreateJobPostProvider(),
  );

  /// Creating a new instance of the `JobDetailRepository` and passing the `jobDetailProvider` to it.
  final JobDetailRepository jobDetailRepository = JobDetailRepository(
    jobDetailProvider: JobDetailProvider(),
  );

  /// Creating a new instance of the `ChatRepository` and passing the `chatProvider` to it.
  final ChatRepository chatRepository = ChatRepository(
    chatProvider: ChatProvider(),
  );

  @override

  /// It sets the sender name to a random name from the list of names.
  void initState() {
    List names = <String>["Bisrat", "Dan", "Abiy", "Sinte", "Kriss"];

    Socket.setSender(names[Random().nextInt(names.length)]);
    // Socket.connectSocket();
    super.initState();
  }

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

        /// Creating a new instance of the `ResetPasswordBloc` and passing the `resetPasswordRepository`
        /// to it.
        BlocProvider(
          create: (context) => ResetPasswordBloc(
            resetPasswordRepository: resetPasswordRepository,
          ),
        ),

        /// Creating a new instance of the `CreateJobPostBloc` and passing the `createJobPostRepository`
        /// to it.
        BlocProvider(
          create: (context) => CreateJobPostBloc(
            createJobPostRepository: createJobPostRepository,
          ),
        ),

        /// Creating a new instance of the `JobDetailBloc` and passing the `jobDetailRepository` to it.
        BlocProvider(
          create: (context) => JobDetailBloc(
            jobDetailRepository: jobDetailRepository,
          ),
        ),

        /// Creating a new instance of the `ChatBloc` and passing the `chatRepository` to it.
        BlocProvider(
          create: (context) => ChatBloc(chatRepository: chatRepository),
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
          home: LoginScreen(),
          // initialRoute: RouteManager.loading_screen,
          onGenerateRoute: RouteManager.generateRoute,
        ),
      ),
    );
  }
}
