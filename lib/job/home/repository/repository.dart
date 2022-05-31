import 'package:balemoya/job/home/data_provider/provider.dart';
import 'package:flutter/cupertino.dart';

/// The HomeRepository class is a class that contains a method called logout that returns a Future of
/// type Object
class HomeRepository {
  final HomeProvider homeProvider;

  HomeRepository({required this.homeProvider});

  /// It calls a function in a provider class, which returns a Future
  ///
  /// Returns:
  ///   The response from the logout() function in the homeProvider.
  Future<Object> logout() async {
    var response = await homeProvider.logout();

    return response;
  }

  Future<Object> getJobPosts({required List sessionID}) async {
    final response = await homeProvider.getJobPosts(sessionID: sessionID);

    return response;
  }
}
