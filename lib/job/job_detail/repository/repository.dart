import 'package:balemoya/job/job_detail/data_provider/provider.dart';
import 'package:balemoya/job/job_detail/models/model.dart';

class JobDetailRepository {
  final JobDetailProvider jobDetailProvider;

  JobDetailRepository({required this.jobDetailProvider});

  Future<Object> applyToJobPost({
    required ApplyJobPostModel applyJobPostModel,
    required List sessionID,
  }) async {
    final response = await jobDetailProvider.applyToJobPost(
      applyJobPostModel: applyJobPostModel,
      sessionID: sessionID,
    );

    return response;
  }
}
