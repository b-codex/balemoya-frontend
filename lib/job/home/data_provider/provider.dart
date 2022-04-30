import 'package:balemoya/static/shared_preference.dart';

class HomeProvider {
  Future<Object> logout() async {
    bool sessionStatus = false;
    SharedPreference sharedPreference = SharedPreference();
    await sharedPreference.clearSession().then((value) {
      if (value != null) {
        sessionStatus = true;
      }
      print(value);
    });

    // print(sessionStatus);
    if (sessionStatus) {
      return {
        'status': 200,
      };
    }
    return {
      'status': 401,
    };
  }
}
