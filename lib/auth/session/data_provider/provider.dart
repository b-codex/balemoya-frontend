import 'package:balemoya/static/shared_preference.dart';

class SessionProvider {
  /// This function checks if there is a user session in the shared preference. If there is, it returns
  /// the status as true and the role of the user. If there isn't, it returns the status as false and the
  /// role as an empty string
  ///
  /// Returns:
  ///   A map with two keys, "status" and "role".
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
      "status": status,
      "role": role,
    };
  }
}
