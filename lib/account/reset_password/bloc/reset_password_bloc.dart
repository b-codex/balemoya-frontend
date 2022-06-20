import 'package:balemoya/account/reset_password/models/models.dart';
import 'package:balemoya/account/reset_password/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordRepository resetPasswordRepository;
  ResetPasswordBloc({required this.resetPasswordRepository})
      : super(ResetPasswordInitial()) {
    on<PasswordResetRequest>((event, emit) async {
      final response = await resetPasswordRepository.passwordResetRequest(
        resetPasswordModel: event.resetPasswordModel,
      ) as Map;

      if (response['success']) {
        emit(PasswordResetSuccess());
      } else {
        emit(PasswordResetFailed());
      }
    });
  }
}
