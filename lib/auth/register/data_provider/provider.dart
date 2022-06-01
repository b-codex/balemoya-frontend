import 'dart:convert';

import 'package:balemoya/auth/register/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:balemoya/static/variables/static_variables.dart';

/// > This class is a provider for the register page
class RegisterProvider {

  /// A variable that holds the api route.
  final String api = apiRoute;

  /// A function that takes in a RegisterModel object and returns a Future object.
  ///
  /// Args:
  ///   registerModel (RegisterModel): The model that contains the data to be sent to the server.
  Future<Object> registerEmployee(RegisterModel registerModel) async {
    final String url = "$api/accountService/users/register-userEmployee";

    final response = await http.post(
      Uri.parse(url),
      body: {
        "fullName": registerModel.name,
        "email": registerModel.email,
        "password": registerModel.password,
        "phoneNumber": registerModel.phone,
        "location": registerModel.location,
      },
    );

    final body = jsonDecode(response.body) as Map;


    if (body['success']) {
      return {
        'status': 200,
      };
    }

    return {
      'status': 404,
      'message': body['message'],
    };
  }

/// It takes a RegisterModel object, and sends it to the server
/// 
/// Args:
///   registerModel (RegisterModel): 
/// 
/// Returns:
///   A map with a status and a message.
  Future<Object> registerOrganization(RegisterModel registerModel) async {
    final String url = "$api/accountService/users/register-userCompany";

    final response = await http.post(
      Uri.parse(url),
      body: {
        "fullName": registerModel.name,
        "email": registerModel.email,
        "password": registerModel.password,
        "phoneNumber": registerModel.phone,
        "location": registerModel.location,
        "description": registerModel.description,
      },
    );
    final body = jsonDecode(response.body) as Map;
    if (body['success']) {
      return {
        'status': 200,
      };
    }
    return {
      'status': 404,
      'message': body['message'],
    };
  }
}
