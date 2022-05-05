import 'package:balemoya/auth/register/data_provider/provider.dart';
import 'package:balemoya/auth/register/models/models.dart';

class RegisterRepository {
  final RegisterProvider registerProvider;

  RegisterRepository({required this.registerProvider});

  Future<Object> register(String type, RegisterModel registerModel) async {
    if (type == "Individual") {
      var response = await registerProvider.registerEmployee(registerModel);
      return response;
    }
    var response = await registerProvider.registerOrganization(registerModel);
    return response;
  }
}
