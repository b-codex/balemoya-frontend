import 'dart:convert';

import 'package:balemoya/account/profile/data_provider/provider.dart';
import 'package:balemoya/account/profile/models/models.dart';

class ProfileRepository {
  final ProfileProvider profileProvider;

  ProfileRepository({required this.profileProvider});

  Future<Object> getProfileInfo({required String sessionID}) async {
    final response =
        await profileProvider.getProfileInfo(sessionID: sessionID) as Map;

    final data = json.decode(response['data']);

    if (response['status'] == 200) {
      final ProfileModel userProfile = ProfileModel(
        profilePicture: data['profilePicture'],
        fullName: data['fullName'],
        location: data['location'],
        email: data['email'],
        phoneNumber: data['phoneNumber'],
        verified: data['verified'],
        role: data['role'],
        portfolio: "data['portfolio']",
        skills: ["data['skills']"],
        cv: "data['cv']",
        previousExperience: data['previousExperience'],
        educationalBackground: data['educationalBackground'],
      );
      return {
        'status': 200,
        'userProfile': userProfile,
      };
    }
    return {
      'status': 404,
    };
  }

  Future<Object> changeProfilePicture({required String filePath}) async {
    final response = await profileProvider.changeProfilePicture(
      filePath: filePath,
    ) as Map;

    if (response['status'] == 200) {
      return {
        'status': response['status'],
        'success': true,
      };
    }
    return {
      'status': response['status'],
      'success': false,
    };
  }

  Future<Object> uploadCV({required String filePath}) async {
    final response = await profileProvider.uploadCV(
      filePath: filePath,
    ) as Map;

    if (response['status'] == 200) {
      return {
        'status': response['status'],
        'success': true,
      };
    }
    return {
      'status': response['status'],
      'success': false,
    };
  }

  Future<Object> editPortfolio({required String editedText}) async {
    final response = await profileProvider.updatePortfolio(
      editedText: editedText,
    );

    return response;
  }

  Future<Object> addPreviousExperience({
    required PreviousExperienceModel previousExperienceModel,
    required List sessionID,
  }) async {
    final response = await profileProvider.addPreviousExperience(
      previousExperienceModel: previousExperienceModel,
      sessionID: sessionID,
    );

    return response;
  }

  Future<Object> addEducationalBackground({
    required EducationModel educationModel,
    required List sessionID,
  }) async {
    final response = await profileProvider.addEducationalBackground(
      educationModel: educationModel,
      sessionID: sessionID,
    );

    return response;
  }

  Future<Object> getVerified({
    required List sessionID,
    required String filePath,
  }) async {
    final response = await profileProvider.getVerified(
      sessionID: sessionID,
      filePath: filePath,
    );

    return response;
  }

  Future<Object> deleteAccount({required String sessionID}) async {
    final response = await profileProvider.deleteAccount(
      sessionID: sessionID,
    );
    return response;
  }

  Future<Object> addReference({
    required String fullName,
    required String phoneNumber,
    required List sessionID,
  }) async {
    final response = await profileProvider.addReference(
      fullName: fullName,
      phoneNumber: phoneNumber,
      sessionID: sessionID,
    );

    return response;
  }

  Future buildResume({required List<String> sessionID}) async {
    final response = await profileProvider.buildResume(
      sessionID: sessionID[1],
    );
    return response;
  }
}
