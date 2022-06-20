import 'package:balemoya/auth/login/data_provider/provider.dart';
import 'package:balemoya/auth/login/models/model.dart';

class LoginRepository {
  final LoginProvider loginProvider;

  LoginRepository({required this.loginProvider});

  Future<Object> attemptLogin(LoginModel loginModel) async {
    final response = await loginProvider.attemptLogin(loginModel) as Map;
    return response;
  }
}
