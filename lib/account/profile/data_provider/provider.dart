import 'package:balemoya/static/shared_preference.dart';

class ProfileProvider {
  Future<Object> getProfileInfo() async {
    late var session;
    SharedPreference sharedPreference = SharedPreference();
    await sharedPreference.getSession().then((value) {
      session = value;
    });
    // send request to server using session id

    // assuming the server sent back successful data
    var response = {
      'profile_picture' : '',
      'name' : '',
      'location' : '',
      'portfolio' : '',
      'skills' : [],
      'cv' : '',
    };

    return response;
  }
}
