import 'package:balemoya/job/create_job_post/models/models.dart';
import 'package:balemoya/job/create_job_post/repository/repository.dart';
import 'package:balemoya/static/shared_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_job_post_event.dart';
part 'create_job_post_state.dart';

class CreateJobPostBloc extends Bloc<CreateJobPostEvent, CreateJobPostState> {
  final CreateJobPostRepository createJobPostRepository;

  CreateJobPostBloc({required this.createJobPostRepository})
      : super(CreateJobPostInitial()) {
    SharedPreference sharedPreference = SharedPreference();

    on<CreateAJobPostEvent>((event, emit) async {
      emit(CreatingPost());
      final sessionID = await sharedPreference.getSession().then(
        (value) {
          return value;
        },
      );
      final response = await createJobPostRepository.createJobPost(
        createJobPostModel: event.createJobPostModel,
        sessionID: sessionID,
      ) as Map;

      await Future.delayed(Duration(seconds: 1));

      if (response['success']) {
        emit(JobPostCreated());
      } else {
        emit(JobPostNotCreated());
      }
    });
  }
}
