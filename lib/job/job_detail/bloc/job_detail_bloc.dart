import 'package:balemoya/job/job_detail/models/model.dart';
import 'package:balemoya/job/job_detail/repository/repository.dart';
import 'package:balemoya/static/shared_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'job_detail_event.dart';
part 'job_detail_state.dart';

class JobDetailBloc extends Bloc<JobDetailEvent, JobDetailState> {
  final JobDetailRepository jobDetailRepository;
  JobDetailBloc({required this.jobDetailRepository})
      : super(JobDetailInitial()) {
    SharedPreference sharedPreference = SharedPreference();
    on<ApplyToJobPostEvent>((event, emit) async {
      final sessionID = await sharedPreference.getSession().then(
        (value) {
          return value;
        },
      );

      final response = await jobDetailRepository.applyToJobPost(
        applyJobPostModel: event.applyJobPostModel,
        sessionID: sessionID,
      ) as Map;

      if (response['success']) {
        emit(AppliedToJobPost());
      } else {
        emit(NotAppliedToJobPost());
      }
    });

    on<PostReviewEvent>((event, emit) async {
      final sessionID = await sharedPreference.getSession().then(
        (value) {
          return value;
        },
      );

      final response = await jobDetailRepository.postReview(
        postReviewModel: event.postReviewModel,
        sessionID: sessionID,
      ) as Map;

      if (response['success']) {
        emit(ReviewPosted());
      } else {
        ReviewNotPosted();
      }
    });
  }
}
