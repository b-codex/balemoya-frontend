import 'package:balemoya/account/reset_password/models/models.dart';
import 'package:balemoya/static/variables/static_variables.dart';
import 'package:http/http.dart' as http;

class ResetPasswordProvider {
  /// It takes a ResetPasswordModel object as a parameter, and returns a Future object
  ///
  /// Args:
  ///   resetPasswordModel (ResetPasswordModel): This is the model that contains the user's email
  /// address.
  ///
  /// Returns:
  ///   A Future<Object>
  Future<Object> passwordResetRequest({
    required ResetPasswordModel resetPasswordModel,
  }) async {
    final String url = "$apiRoute/accountService/users/update-password";

    final response = await http.put(Uri.parse(url));

    if (response.statusCode == 200) {
      return {
        "success": true,
      };
    }
    return {
      "success": false,
    };
  }
}
