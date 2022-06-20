part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class PasswordResetSuccess extends ResetPasswordState {}

class PasswordResetFailed extends ResetPasswordState {}