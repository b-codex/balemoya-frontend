class RegisterModel {
  final String name, email, phone, password, location, userType, description;

  RegisterModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.location,
    required this.userType,
    this.description = "",
  });
}
