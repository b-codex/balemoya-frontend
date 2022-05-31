part of 'job_detail_bloc.dart';

@immutable
abstract class JobDetailEvent {}

class ApplyToJobPostEvent extends JobDetailEvent {
  final ApplyJobPostModel applyJobPostModel;

  ApplyToJobPostEvent({required this.applyJobPostModel});
}