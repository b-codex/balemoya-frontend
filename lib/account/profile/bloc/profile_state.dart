part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadDone extends ProfileState {
  final ProfileModel profileModel;

  ProfileLoadDone({required this.profileModel});
}

class LoadingProfile extends ProfileState {}

class ProfileLoadingFailed extends ProfileState {}

class ChangeProfilePictureFailed extends ProfileState {}

class ChangeProfilePictureSuccess extends ProfileState {}

class UploadCVSuccess extends ProfileState {}

class UploadCVFailed extends ProfileState {}

class PortfolioUpdateSuccess extends ProfileState {}

class PortfolioUpdateFailed extends ProfileState {}

class SkillsUpdateSuccess extends ProfileState {}

class SkillsUpdateFailed extends ProfileState {}

class DeleteAccountSuccess extends ProfileState {}

class DeleteAccountFailed extends ProfileState {}

class SkillAdded extends ProfileState {}

class SkillAddingFailed extends ProfileState {}

class PreviousExperienceAdded extends ProfileState {}

class PreviousExperienceAddingFailed extends ProfileState {}

class EducationalBackgroundAdded extends ProfileState {}

class EducationalBackgroundAddingFailed extends ProfileState {}

class VerificationRequestSuccess extends ProfileState {}

class VerificationRequestFailed extends ProfileState {}

class ReferenceAdded extends ProfileState {}

class ReferenceNotAdded extends ProfileState {}
