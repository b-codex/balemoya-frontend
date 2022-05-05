import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  Future saveSession({required String name, required String sessionID}) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('sessionInfo', <String>[name, sessionID]);

    return "Session Saved";
  }

  Future getSession() async {
    final preferences = await SharedPreferences.getInstance();
    List? sessionInfo = preferences.getStringList('sessionInfo');

    return sessionInfo;
  }

  Future clearSession() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    return "Session Cleared";
  }
}
