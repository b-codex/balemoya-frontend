part of 'user_session_bloc.dart';

abstract class UserSessionState {}

class UserSessionInitial extends UserSessionState {}

class UserSessionFound extends UserSessionState {}

class UserSessionNotFound extends UserSessionState {}
