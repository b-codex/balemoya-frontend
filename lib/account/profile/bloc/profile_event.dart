part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class ChangeProfilePictureEvent extends ProfileEvent {
  final String filePath;

  ChangeProfilePictureEvent({required this.filePath});
}

class ResumeBuilderEvent extends ProfileEvent {}

class DeleteAccountEvent extends ProfileEvent {}

class ResetPasswordEvent extends ProfileEvent {}

class UploadCVEvent extends ProfileEvent {
  final String filePath;

  UploadCVEvent({required this.filePath});
}

class EditPortfolioEvent extends ProfileEvent {
  final String editedText;

  EditPortfolioEvent({required this.editedText});
}

class EditSkillsEvent extends ProfileEvent {
  final List<String> editedSkills;

  EditSkillsEvent({required this.editedSkills});
}

class AddSkillEvent extends ProfileEvent {
  final String skill;

  AddSkillEvent({required this.skill});
}

class AddPreviousExperience extends ProfileEvent {
  final PreviousExperienceModel previousExperienceModel;

  AddPreviousExperience({required this.previousExperienceModel});
}

class AddEducationalBackground extends ProfileEvent {
  final EducationModel educationModel;

  AddEducationalBackground({required this.educationModel});
}

class GetVerifiedEvent extends ProfileEvent {
  final String filePath;

  GetVerifiedEvent({required this.filePath});
}

class AddReferenceEvent extends ProfileEvent {
  final String fullName;
  final String phoneNumber;

  AddReferenceEvent({required this.fullName, required this.phoneNumber});
}

class BuildResumeEvent extends ProfileEvent {}
