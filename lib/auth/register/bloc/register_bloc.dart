import 'package:balemoya/auth/register/models/models.dart';
import 'package:balemoya/auth/register/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;
  RegisterBloc({required this.registerRepository}) : super(RegisterInitial()) {
    on<RegisterNow>(
      (event, emit) async {
        emit(Loading());
        await Future.delayed(Duration(seconds: 2));

        var response = await registerRepository.register(
            event.registerData.userType, event.registerData) as Map;
        if (response['status'] == 200) {
          emit(RegisterSuccess());
        } else {
          emit(
            RegisterFailed(
              message: response['message'],
            ),
          );
        }
      },
    );

    //changing user type
    on<ChangeUserType>(
      (event, emit) {
        emit(
          UserTypeChanged(
            to: event.to,
          ),
        );
      },
    );
  }
}
