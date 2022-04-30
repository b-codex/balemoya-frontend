import 'package:balemoya/auth/login/models/model.dart';
import 'package:balemoya/functions/encrypt_password.dart';
import 'package:balemoya/static/shared_preference.dart';

class LoginProvider {
  Future<Object> attemptLogin(LoginModel loginModel) async {
    String dummyPassword = hashValue(password: '123456');
    if (loginModel.username == 'bisrat' &&
        loginModel.password == dummyPassword) {
      _saveSession(name: loginModel.username, sessionID: '895612894451');
      return {
        'status': 200,
        'id': '895612894451',
        'name': 'bisrat',
      };
    }
    return {
      'status': 404,
    };
  }
}

_saveSession({
  required String name,
  required String sessionID,
}) async {
  final sharedPreferences = SharedPreference();

  // saving session
  var response =
      await sharedPreferences.saveSession(name: name, sessionID: sessionID);
  return response;
}
