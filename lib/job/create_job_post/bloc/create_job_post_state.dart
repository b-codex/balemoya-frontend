part of 'create_job_post_bloc.dart';

@immutable
abstract class CreateJobPostState {}

class CreateJobPostInitial extends CreateJobPostState {}

class JobPostCreated extends CreateJobPostState {}

class CreatingPost extends CreateJobPostState {}

class JobPostNotCreated extends CreateJobPostState {}
