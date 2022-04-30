part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class LogoutEvent extends HomeEvent {}

class AccountButtonClick extends HomeEvent {}

class BookmarksButtonClick extends HomeEvent {}
