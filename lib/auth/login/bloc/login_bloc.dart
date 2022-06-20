import 'package:balemoya/auth/login/models/model.dart';
import 'package:balemoya/auth/login/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<AttemptLogin>((event, emit) async {
      emit(Loading());

      final response =
          await loginRepository.attemptLogin(event.loginModel) as Map;
      print(response);
      if (response['status'] == 200) {
        emit(
          LoginSuccess(
            role: response['role'],
          ),
        );
      }
      if (response['status'] != 200) {
        emit(LoginFailed());
      }
    });
  }
}
