part of 'job_detail_bloc.dart';

@immutable
abstract class JobDetailEvent {}

class ApplyToJobPostEvent extends JobDetailEvent {
  final ApplyJobPostModel applyJobPostModel;

  ApplyToJobPostEvent({required this.applyJobPostModel});
}

class PostReviewEvent extends JobDetailEvent {
  final PostReviewModel postReviewModel;

  PostReviewEvent({required this.postReviewModel});
}

class EditJobPostEvent extends JobDetailEvent {
  final EditJobPostModel editJobPostModel;

  EditJobPostEvent({required this.editJobPostModel});
}
