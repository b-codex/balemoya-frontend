part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordEvent {}

class PasswordResetRequest extends ResetPasswordEvent {
  final ResetPasswordModel resetPasswordModel;

  PasswordResetRequest({required this.resetPasswordModel});
}
