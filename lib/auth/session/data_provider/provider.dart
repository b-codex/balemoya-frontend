import 'package:balemoya/static/shared_preference.dart';

class SessionProvider {
  Future<Object> checkUserSession() async {
    bool status = false;
    String role = "";
    final sharedPreferences = SharedPreference();

    // getting session id from shared preference
    await sharedPreferences.getSession().then(
      (value) {
        // if there exists a value, the status == true (meaning there is a user session)
        if (value != null) {
          role = value[2];
          status = true;
        }
      },
    );
    // if a value isn't found, status == false (meaning there is no user session)
    return {
      "status" : status,
      "role" : role,
    };
  }
}
