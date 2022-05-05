import 'dart:convert';

import 'package:balemoya/auth/login/models/model.dart';
import 'package:balemoya/static/shared_preference.dart';
import 'package:http/http.dart' as http;

/// A dummy url for testing.
final url = "http://account-service-1.herokuapp.com/api/users/login";

/// > This class is a provider for the login page
class LoginProvider {
  /// It attempts to login the user.
  /// 
  /// Args:
  ///   loginModel (LoginModel): The model that contains the username and password.
  Future<Object> attemptLogin(LoginModel loginModel) async {

   /// Making a post request to the url and then decoding the response body to a map.
    final response = await http.post(
      Uri.parse(url),
      body: {"email": loginModel.email, "password": loginModel.password},
    );

    /// Decoding the response body to a map.
    final body = jsonDecode(response.body) as Map;

    /// This is checking if the response status code is 200, if it is, it will save the session and
    /// return the status code, id and email.
    if (response.statusCode == 200) {
      _saveSession(
        name: loginModel.email,
        sessionID: body['token'],
      );
      return {
        'status': 200,
        'id': body['token'],
        'email': loginModel.email,
      };
    }
    /// Returning a map with a status of 404.
    return {
      'status': 404,
    };
  }
}

/// _saveSession() is an async function that takes in two required parameters, name and sessionID. It
/// then calls the saveSession() function from the SharedPreference class and returns the response
/// 
/// Args:
///   name (String): The name of the session.
///   sessionID (String): The session ID is a unique identifier that is generated for authenticating
/// users.
/// 
/// Returns:
///   A bool;
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
