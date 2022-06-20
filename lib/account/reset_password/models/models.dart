class ResetPasswordModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String newPassword;
  final String securityQuestion1;
  final String securityQuestion2;
  final String securityQuestion3;

  ResetPasswordModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.securityQuestion1,
    required this.securityQuestion2,
    required this.securityQuestion3,
    required this.newPassword,
  });
}
