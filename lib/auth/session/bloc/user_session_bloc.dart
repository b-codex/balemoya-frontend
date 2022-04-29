import 'package:balemoya/auth/session/repository/repository.dart';
import 'package:bloc/bloc.dart';

part 'user_session_event.dart';
part 'user_session_state.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  final SessionRepository sessionRepository;
  UserSessionBloc({required this.sessionRepository})
      : super(UserSessionInitial()) {
    // checking user session event
    on<CheckUserSessionEvent>(
      (event, emit) async {
        final response = await sessionRepository.checkUserSession();
        if (response) {
          await Future.delayed(Duration(seconds: 1));
          emit(UserSessionFound());
        }
        await Future.delayed(Duration(seconds: 1));
        emit(UserSessionNotFound());
      },
    );
  }
}
