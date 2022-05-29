import 'dart:convert';

import 'package:balemoya/account/profile/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:balemoya/static/variables/static_variables.dart';

/// It's a class that has a method that returns a future object
class ProfileProvider {
  /// It returns a Future object.
  Future<Object> getProfileInfo({required String sessionID}) async {
    final url = "$apiRoute/accountService/users/profile";
    final response = await http.get(Uri.parse(url), headers: {
      // "Content-Type": "application/json",
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $sessionID'
    });

    if (response.statusCode == 200) {
      return {
        'status': 200,
        'data': response.body,
      };
    }
    return {
      'status': 404,
    };
  }

  Future<Object> uploadCV({required String filePath}) async {
    final url = "http://account-service-1.herokuapp.com/";
    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      await http.MultipartFile.fromPath(
        'CV',
        filePath,
        // contentType: MediaType('application', 'x-tar'),
      ),
    );
    return {};
  }

  Future<Object> changeProfilePicture({required String filePath}) async {
    final url = "http://account-service-1.herokuapp.com/";
    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      await http.MultipartFile.fromPath(
        'profile picture',
        filePath,
        // contentType: MediaType('application', 'x-tar'),
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      return {
        'status': 200,
      };
    }

    return {
      'status': 404,
    };
  }

  Future<Object> updatePortfolio({required String editedText}) async {
    final url = "http://account-service-1.herokuapp.com/";
    final response = await http.put(Uri.parse(url), body: {
      'updatedPortfolio': editedText,
    });

    if (response.statusCode == 200) {
      return {
        'status': 200,
      };
    }

    return {
      'status': 404,
    };
  }

  Future<Object> updateSkills({required List<String> skills}) async {
    final url = "http://account-service-1.herokuapp.com/";
    final response = await http.put(Uri.parse(url), body: {
      'skills': skills,
    });

    if (response.statusCode == 200) {
      return {
        'status': 200,
      };
    }

    return {
      'status': 404,
    };
  }

  Future<Object> deleteAccount({required String sessionID}) async {
    final url = "http://account-service-1.herokuapp.com/users";
    final response = await http.delete(Uri.parse(url), body: {
      'sessionID': sessionID,
    });
    if (response.statusCode == 200) {
      return {
        'status': 200,
      };
    }
    return {
      'status': 404,
    };
  }

  Future<Object> addSKill({
    required String skill,
    required String sessionID,
  }) async {
    final url = "$apiRoute/accountService/users/update";
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $sessionID'
      },
      body: {
        'skills': skill,
      },
    );
    if (response.statusCode == 200) {
      return {"success": true};
    }
    return {"success": false};
  }

  Future<Object> addPreviousExperience({
    required PreviousExperienceModel previousExperienceModel,
    required List sessionID,
  }) async {
    final url =
        "$apiRoute/accountService/employee/previousExperience/experience";

    final response = await http.post(Uri.parse(url), body: {
      "id": sessionID[3],
      "organizationName": previousExperienceModel.organizationName,
      "position": previousExperienceModel.position,
      "duration": previousExperienceModel.duration,
      "dateStarted": previousExperienceModel.dateStarted,
      "currentActivity": "true",
    }, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${sessionID[1]}'
    });

    final body = json.decode(response.body);

    if (body['success'] == true) {
      return {
        "success": true,
        "response": body,
      };
    }

    return {
      "success": false,
    };
  }

  Future<Object> addEducationalBackground({
    required EducationModel educationModel,
    required List sessionID,
  }) async {
    final url =
        "$apiRoute/accountService/employee/educationalBackground/educationalBackground";

    final response = await http.post(Uri.parse(url), body: {
      "userID": sessionID[3],
      "institution": educationModel.institution,
      "educationLevel": educationModel.educationLevel,
      "fieldOfStudy": educationModel.fieldOfStudy,
      "startedDate": educationModel.startedDate,
      "endDate": educationModel.endDate,
    }, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${sessionID[1]}'
    });

    print(response.body);
    if (response.statusCode == 201) {
      return {
        "success": true,
        "response": response.body,
      };
    }

    return {
      "success": false,
    };
  }
}
