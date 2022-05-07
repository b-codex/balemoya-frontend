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
