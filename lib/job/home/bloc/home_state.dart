part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoggedOut extends HomeState {}

class LoggingOutFailed extends HomeState {}
