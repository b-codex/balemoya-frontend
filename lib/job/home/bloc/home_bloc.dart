import 'dart:convert';

import 'package:balemoya/auth/login/bloc/login_bloc.dart';
import 'package:balemoya/job/home/repository/repository.dart';
import 'package:balemoya/static/shared_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  SharedPreference sharedPreference = SharedPreference();

  /// A constructor.
  HomeBloc({required this.homeRepository}) : super(HomeInitial()) {
    /// Listening to the event and emitting the state.
    /// logout event
    on<LogoutEvent>(
      (event, emit) async {
        var response = await homeRepository.logout() as Map;

        if (response['status'] == 200) {
          emit(LoggedOut());
        } else {
          emit(LoggingOutFailed());
        }
      },
    );

    // get job posts
    on<GetJobPosts>((event, emit) async {
      await Future.delayed(Duration(seconds: 2));
      final sessionID = await sharedPreference.getSession().then(
        (value) {
          return value;
        },
      );
      if (sessionID == null) {
        emit(GetJobPostsFailed());
      }
      print(sessionID);
      final response =
          await homeRepository.getJobPosts(sessionID: sessionID) as Map;

      if (response['success']) {
        final jobs = json.decode(response['data']);
        emit(GetJobPostsSuccess(jobs: jobs));
      } else {
        emit(GetJobPostsFailed());
      }
    });
  }
}
