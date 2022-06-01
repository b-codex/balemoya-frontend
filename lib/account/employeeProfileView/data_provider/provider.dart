import 'package:balemoya/account/employeeProfileView/models/models.dart';
import 'package:balemoya/static/variables/static_variables.dart';
import 'package:http/http.dart' as http;

class EmployeeProfileViewProvider {
  Future<Object> reportAccount({
    required ReportModel reportModel,
    required List sessionID,
  }) async {
    final url = "$apiRoute/accountService/employee/reports/reports";
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
