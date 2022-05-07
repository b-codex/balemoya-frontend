import 'package:http/http.dart' as http;

/// It's a class that has a method that returns a future object
class ProfileProvider {
  /// It returns a Future object.
  Future<Object> getProfileInfo({required String sessionID}) async {
    final url = "https://google.com";
    final response = await http.post(Uri.parse(url), body: {
      "sessionID": sessionID,
    });

    if (response.statusCode == 200) {
      return {
        'status': 404,
        'response': response,
      };
    }
    return {
      'status': 404,
    };
  }

  Future<Object> uploadCV({required String filePath}) async {
    final url = "http://account-service-1.herokuapp.com/";
    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      await http.MultipartFile.fromPath(
        'CV',
        filePath,
        // contentType: MediaType('application', 'x-tar'),
      ),
    );
    return {};
  }

  Future<Object> changeProfilePicture({required String filePath}) async {
    final url = "http://account-service-1.herokuapp.com/";
    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      await http.MultipartFile.fromPath(
        'profile picture',
        filePath,
        // contentType: MediaType('application', 'x-tar'),
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      return {
        'status': 200,
      };
    }

    return {
      'status': 404,
    };
  }
}
