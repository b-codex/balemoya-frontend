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
