
class ProfileModel {
  final String profilePicture;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String location;
  final bool verified;
  final String portfolio;
  final List<String> skills;
  final String cv;
  final String role;
  final List previousExperience;
  final List educationalBackground;

  ProfileModel(
      {required this.profilePicture,
      required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.location,
      required this.verified,
      required this.portfolio,
      required this.skills,
      required this.cv,
      required this.role,
      required this.previousExperience,
      required this.educationalBackground});
}

class PreviousExperienceModel {
  final String organizationName;
  final String position;
  final String duration;
  final String dateStarted;

  PreviousExperienceModel({
    required this.organizationName,
    required this.position,
    required this.duration,
    required this.dateStarted,
  });
}

class EducationModel {
  final String institution;
  final String educationLevel;
  final String fieldOfStudy;
  final String startedDate;
  final String endDate;

  EducationModel({
    required this.institution,
    required this.educationLevel,
    required this.fieldOfStudy,
    required this.startedDate,
    required this.endDate,
  });
}
