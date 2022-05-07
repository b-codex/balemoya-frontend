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
