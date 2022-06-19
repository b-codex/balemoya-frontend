import 'package:balemoya/job/create_job_post/data_provider/provider.dart';
import 'package:balemoya/job/create_job_post/models/models.dart';

class CreateJobPostRepository {
  final CreateJobPostProvider createJobPostProvider;

  CreateJobPostRepository({required this.createJobPostProvider});

  Future<Object> createJobPost({
    required CreateJobPostModel createJobPostModel,
    required List sessionID,
  }) async {
    final response = await createJobPostProvider.createJobPost(
      createJobPostModel: createJobPostModel,
      sessionID: sessionID
    );

    return response;
  }
}
