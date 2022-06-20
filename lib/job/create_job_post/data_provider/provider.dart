import 'dart:convert';

import 'package:balemoya/job/create_job_post/models/models.dart';
import 'package:balemoya/static/variables/static_variables.dart';
import 'package:http/http.dart' as http;

class CreateJobPostProvider {
  Future<Object> createJobPost(
      {required CreateJobPostModel createJobPostModel,
      required List sessionID}) async {
    final String url = "$apiRoute/jobService/employer/jobPost/create";
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
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
        "postedBy": sessionID[3],
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sessionID[1]}'
      },
    );
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
