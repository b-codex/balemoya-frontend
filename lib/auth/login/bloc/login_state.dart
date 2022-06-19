part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final String role;

  LoginSuccess({required this.role});
}

class LoginFailed extends LoginState {}

class Loading extends LoginState {}
