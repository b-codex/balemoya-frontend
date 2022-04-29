import 'package:balemoya/auth/session/bloc/user_session_bloc.dart';
import 'package:balemoya/auth/session/data_provider/provider.dart';
import 'package:balemoya/auth/session/repository/repository.dart';
import 'package:balemoya/static/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // session repository
  final SessionRepository sessionRepository = SessionRepository(
    sessionProvider: SessionProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => UserSessionBloc(
            sessionRepository: sessionRepository,
          ),
        ),
      ],
      child: RepositoryProvider.value(
        value: sessionRepository,
        child: MaterialApp(
          title: 'BaleMoya',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            textTheme: GoogleFonts.montserratTextTheme(),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: RouteManager.loading_screen,
          onGenerateRoute: RouteManager.generateRoute,
        ),
      ),
    );
  }
}
