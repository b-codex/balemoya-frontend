part of 'create_job_post_bloc.dart';

@immutable
abstract class CreateJobPostEvent {}

class CreateAJobPostEvent extends CreateJobPostEvent {
  final CreateJobPostModel createJobPostModel;

  CreateAJobPostEvent({required this.createJobPostModel});
}
