part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class AttemptLogin extends LoginEvent {
  final LoginModel loginModel;

  AttemptLogin({required this.loginModel});
}
