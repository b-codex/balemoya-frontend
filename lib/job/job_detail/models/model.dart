class ApplyJobPostModel {
  final String email;
  final String phoneNumber;
  final String text;
  final String jobID;

  ApplyJobPostModel({
    required this.email,
    required this.phoneNumber,
    required this.text,
    required this.jobID,
  });
}

class PostReviewModel {
  final String fullName;
  final String review;
  final String jobID;

  PostReviewModel({required this.fullName, required this.review, required this.jobID});
}
