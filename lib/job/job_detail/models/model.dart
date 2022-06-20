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

  PostReviewModel({
    required this.fullName,
    required this.review,
    required this.jobID,
  });
}

class EditJobPostModel {
  final String companyName;
  final String jobTitle;
  final String location;
  final String salary;
  final String shortDescription;
  final String requirements;
  final String qualification;
  final String tag;
  final String companySize;
  final String jobType;
  final String id;

  EditJobPostModel({
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.salary,
    required this.shortDescription,
    required this.requirements,
    required this.qualification,
    required this.tag,
    required this.companySize,
    required this.jobType,
  });
}
