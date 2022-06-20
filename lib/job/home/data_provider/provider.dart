import 'dart:convert';

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

  /// It makes a GET request to the server, and returns the response body if the request is successful
  ///
  /// Args:
  ///   sessionID (List): List of two strings, the first is the user's email, the second is the user's
  /// token.
  ///
  /// Returns:
  ///   A Future Object.
  ///
  Future<Object> getJobPosts({required List sessionID}) async {
    final url = "$apiRoute/jobService/employer/jobPost";
    final response = await http.get(Uri.parse(url), headers: {
      // 'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${sessionID[1]}'
    });
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

class JobSearchProvider {
  Future<dynamic> searchJob(
      {required List sessionID,
      required String query,
      required dynamic jobType}) async {
    final url = "$apiRoute/jobService/employer/jobPost/search";
    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${sessionID[1]}',
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({"query": query, "jobType": jobType}));
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
