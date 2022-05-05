part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String message;

  RegisterFailed({required this.message});
}

class UserTypeChanged extends RegisterState {
  final String to;

  UserTypeChanged({required this.to});
}

class Loading extends RegisterState {}
