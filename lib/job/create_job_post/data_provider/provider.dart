import 'package:balemoya/job/create_job_post/models/models.dart';
import 'package:balemoya/static/variables/static_variables.dart';
import 'package:http/http.dart' as http;

class CreateJobPostProvider {
  Future<Object> createJobPost(
      {required CreateJobPostModel createJobPostModel,
      required List sessionID}) async {
    final String url = "$apiRoute/jobService/employer/jobPost";

    final response = await http.post(
      Uri.parse(url),
      body: {
        "jobTitle": createJobPostModel.jobTitle,
        "companyName": createJobPostModel.companyName,
        "jobType": createJobPostModel.jobType,
        "description": createJobPostModel.shortDescription,
        "requirements": createJobPostModel.requirements,
        "qualification": createJobPostModel.qualification,
        "location": createJobPostModel.location,
        "tag": createJobPostModel.tag,
        "salary": createJobPostModel.salary,
        "companySize": createJobPostModel.companySize,
      },
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${sessionID[1]}'
      },
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
