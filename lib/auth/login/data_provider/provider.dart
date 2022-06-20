import 'dart:convert';

import 'package:balemoya/auth/login/models/model.dart';
import 'package:balemoya/chat/screens/chat_page.dart';
import 'package:balemoya/static/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:balemoya/static/variables/static_variables.dart';

/// A variable that is storing the url of the api.
final String url = "$apiRoute/accountService/users/login";

/// > This class is a provider for the login page
class LoginProvider {
  /// It attempts to login the user.
  ///
  /// Args:
  ///   loginModel (LoginModel): The model that contains the username and password.
  Future<Object> attemptLogin(LoginModel loginModel) async {
    var body = {"email": loginModel.email, "password": loginModel.password};

    /// Making a post request to the url and then decoding the response body to a map.
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      /// This is checking if the response status code is 200, if it is, it will save the session and
      /// return the status code, id and email.
      if (response.statusCode == 200) {
        /// Decoding the response body to a map.
        final body = jsonDecode(response.body) as Map;

        /// Saving the session.
        _saveSession(
          fullName: body['fullName'],
          sessionID: body['token'],
          role: body['role'],
          userID: body['id'],
        );

        ChatPage.setCurrentUser(body['id']);
        ChatPage.setToken(body['token']);

        return {
          'status': 200,
          'id': body['token'],
          'role': body['role'],
          'email': loginModel.email,
        };
      }

      /// Returning a map with a status of 404.
      return {
        'status': 404,
      };
    } catch (error) {
      /// Returning a map with a status of 404.
      return {
        'status': 404,
      };
    }
  }
}

/// _saveSession() is a function that saves the session of the user
///
/// Args:
///   fullName (String): The user's full name
///   sessionID (String): This is the session ID that is returned from the server.
///   role (String): is the role of the user,
///   userID (String): The user's ID
///
/// Returns:
///   A Future&lt;bool&gt;
_saveSession({
  required String fullName,
  required String sessionID,
  required String role,
  required String userID,
}) async {
  final sharedPreferences = SharedPreference();

  // saving session
  var response = await sharedPreferences.saveSession(
    fullName: fullName,
    sessionID: sessionID,
    role: role,
    userID: userID,
  );
  return response;
}
