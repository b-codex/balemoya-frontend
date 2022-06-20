part of 'user_session_bloc.dart';

abstract class UserSessionState {}

class UserSessionInitial extends UserSessionState {}

class UserSessionFound extends UserSessionState {
  final String role;

  UserSessionFound({required this.role});
}

class UserSessionNotFound extends UserSessionState {}
