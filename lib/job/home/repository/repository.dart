import 'package:balemoya/job/home/data_provider/provider.dart';

class HomeRepository {
  final HomeProvider homeProvider;

  HomeRepository({required this.homeProvider});

  Future<Object> logout() async {
    var response = await homeProvider.logout();
    
    return response;
  }
}
