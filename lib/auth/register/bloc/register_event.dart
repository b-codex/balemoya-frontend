part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterNow extends RegisterEvent {
  final RegisterModel registerData;

  RegisterNow({required this.registerData});
}

class ChangeUserType extends RegisterEvent {
  final String to;

  ChangeUserType({required this.to});
}
