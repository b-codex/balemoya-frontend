import 'package:shared_preferences/shared_preferences.dart';

/// The class is used to save, get and clear a sessionID and name in the shared preferences of the
/// device.
class SharedPreference {
  /// This function takes in a name and a sessionID, then saves them to the device's local storage
  ///
  /// Args:
  ///   name (String): The name of the user
  ///   sessionID (String): The session ID that you get from the server.
  ///
  /// Returns:
  ///   A Future object.
  Future saveSession({required String fullName, required String sessionID, required String role, required String userID}) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('sessionInfo', <String>[fullName, sessionID, role, userID]);

    return "Session Saved";
  }

  /// It gets the sessionInfo from the shared preferences and returns it
  ///
  /// Returns:
  ///   A Future object.
  Future getSession() async {
    final preferences = await SharedPreferences.getInstance();
    List? sessionInfo = preferences.getStringList('sessionInfo');

    return sessionInfo;
  }

  /// It gets the shared preferences instance, clears it, and returns a string
  ///
  /// Returns:
  ///   A Future object.
  Future clearSession() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    return "Session Cleared";
  }
}
