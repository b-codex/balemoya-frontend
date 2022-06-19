import 'package:balemoya/account/employeeProfileView/models/models.dart';
import 'package:balemoya/static/variables/static_variables.dart';
import 'package:http/http.dart' as http;

class EmployeeProfileViewProvider {
  /// It takes a ReportModel object and a list of sessionID's and returns a Future object.
  /// 
  /// Args:
  ///   reportModel (ReportModel): A model that contains the reason and comment for the report.
  ///   sessionID (List): List of 4 elements, the first element is the user's ID, the second element is
  /// the user's access token, the third element is the user's refresh token, and the fourth element is
  /// the user's username.
  /// 
  /// Returns:
  ///   A Future<Object>
  Future<Object> reportAccount({
    required ReportModel reportModel,
    required List sessionID,
  }) async {
    final url = "$apiRoute/accountService/employee/reports/reports";
    /// Sending a POST request to the server.
    final response = await http.post(
      Uri.parse(url),
      body: {
        "reportedReason": reportModel.reason,
        "comment": reportModel.comment,
        "reportee": sessionID[3],
      },
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${sessionID[1]}'
      },
    );
    if (response.statusCode == 201) {
      return {
        "success": true,
      };
    } else {
      return {
        "success": false,
      };
    }
  }
}
