part of 'job_detail_bloc.dart';

@immutable
abstract class JobDetailState {}

class JobDetailInitial extends JobDetailState {}

class AppliedToJobPost extends JobDetailState {}

class NotAppliedToJobPost extends JobDetailState {}

class ReviewPosted extends JobDetailState {}

class ReviewNotPosted extends JobDetailState {}

class JobPostEdited extends JobDetailState {}

class JobPostNotEdited extends JobDetailState {}
