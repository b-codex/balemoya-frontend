import 'package:balemoya/job/job_detail/models/model.dart';
import 'package:balemoya/static/variables/static_variables.dart';
import 'package:http/http.dart' as http;

class JobDetailProvider {
  Future<Object> applyToJobPost({
    required ApplyJobPostModel applyJobPostModel,
    required List sessionID,
  }) async {
    final url =
        "$apiRoute/jobService/employee/applyForJob/applyForJob/${applyJobPostModel.jobID}";
    final response = await http.post(
      Uri.parse(url),
      body: {
        "email": applyJobPostModel.email,
        "phoneNumber": applyJobPostModel.phoneNumber,
        "text": applyJobPostModel.text,
      },
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${sessionID[1]}'
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
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
