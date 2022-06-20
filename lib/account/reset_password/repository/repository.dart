import 'package:balemoya/account/reset_password/data_provider/provider.dart';
import 'package:balemoya/account/reset_password/models/models.dart';

class ResetPasswordRepository {
  final ResetPasswordProvider resetPasswordProvider;
  ResetPasswordRepository({required this.resetPasswordProvider});

  Future<Object> passwordResetRequest({
    required ResetPasswordModel resetPasswordModel,
  }) async {
    final response = await resetPasswordProvider.passwordResetRequest(
      resetPasswordModel: resetPasswordModel,
    );

    return response;
  }
}
