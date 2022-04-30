import 'package:balemoya/auth/register/data_provider/provider.dart';
import 'package:balemoya/auth/register/models/models.dart';

class RegisterRepository {
  final RegisterProvider registerProvider;

  RegisterRepository({required this.registerProvider});

  Future<Object> register(RegisterModel registerModel) async {
    var response = await registerProvider.register(registerModel);
    return response;
  }
}
