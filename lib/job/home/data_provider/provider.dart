import 'package:balemoya/static/shared_preference.dart';
import 'package:balemoya/static/variables/static_variables.dart';
import 'package:http/http.dart' as http;

/// It clears the session and returns a status code
class HomeProvider {
  /// It clears the session and returns a status code
  ///
  /// Returns:
  ///   A Future object.
  Future<Object> logout() async {
    bool sessionStatus = false;
    SharedPreference sharedPreference = SharedPreference();
    await sharedPreference.clearSession().then((value) {
      if (value != null) {
        sessionStatus = true;
      }
    });

    if (sessionStatus) {
      return {
        'status': 200,
      };
    }
    return {
      'status': 401,
    };
  }

  Future<Object> getJobPosts({required List sessionID}) async {
    final url = "$apiRoute/jobService/employer/jobPost";
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${sessionID[1]}'
    });
    // print(response.body);
    if (response.statusCode == 200) {
      return {
        "success": true,
        "data": response.body,
      };
    } else {
      return {
        "success": false,
      };
    }
  }
}
