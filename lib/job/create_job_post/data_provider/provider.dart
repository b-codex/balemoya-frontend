import 'package:balemoya/job/create_job_post/models/models.dart';
import 'package:balemoya/static/variables/static_variables.dart';
import 'package:http/http.dart' as http;

class CreateJobPostProvider {
  Future<Object> createJobPost({
    required CreateJobPostModel createJobPostModel,
    required List sessionID
  }) async {
    final String url =
        "$apiRoute/microservice/accountService/employer/jobPost/${sessionID[3]}";

    final response = await http.post(
      Uri.parse(url),
      body: {},
      headers: {},
    );

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
