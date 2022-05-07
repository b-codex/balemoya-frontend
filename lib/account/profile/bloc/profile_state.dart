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
