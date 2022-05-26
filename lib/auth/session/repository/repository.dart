import 'package:balemoya/auth/session/data_provider/provider.dart';

class SessionRepository {
  final SessionProvider sessionProvider;

  SessionRepository({required this.sessionProvider});

  Future<Object> checkUserSession() async {
    final result = await sessionProvider.checkUserSession();
    
    return result; // true, if there exists a user session or false, if there doesn't exist a user session
  }
}
