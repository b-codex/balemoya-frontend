part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoggedOut extends HomeState {}

class LoggingOutFailed extends HomeState {}

class GetJobPostsSuccess extends HomeState {
  final List jobs;

  GetJobPostsSuccess({required this.jobs});
}

class GetJobPostsFailed extends HomeState {}
