

class CreateJobPostModel {
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
  final String companyLogo;

  CreateJobPostModel({
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
    required this.companyLogo,
  });
}
