import 'package:balemoya/job/job_detail/models/model.dart';
import 'package:balemoya/static/variables/static_variables.dart';
import 'package:http/http.dart' as http;

class JobDetailProvider {
  /// It takes in a model and a list of sessionID and returns a map of success or failure
  ///
  /// Args:
  ///   applyJobPostModel: This is a model class that contains the data that is being sent to the server.
  ///   sessionID (List): List of two strings, the first is the user's email, the second is the user's
  /// token.
  ///
  /// Returns:
  ///   A Map with a key of success and a value of true or false.
  Future<Object> applyToJobPost({
    required applyJobPostModel,
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

  /// It takes a PostReviewModel object and a list of sessionID's and returns a map with a key of success
  /// and a value of true or false
  ///
  /// Args:
  ///   postReviewModel (PostReviewModel): This is a model that contains the review, jobID, and fullName.
  ///   sessionID (List): List of two strings, the first is the user's email, the second is the user's
  /// token.
  ///
  /// Returns:
  ///   A map with a key of success and a value of true or false.
  Future postReview({
    required PostReviewModel postReviewModel,
    required List sessionID,
  }) async {
    final url =
        "$apiRoute/accountService/users/reviews/reviews/${postReviewModel.jobID}";
    final response = await http.post(
      Uri.parse(url),
      body: {
        "comment": postReviewModel.review,
        "fullName": postReviewModel.fullName,
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

  Future<bool> deleteJob(
      {required String sessionID, required String jobId}) async {
    final url = "$apiRoute/jobService/employer/jobPost/$jobId";
    print(url);
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${sessionID}'
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
