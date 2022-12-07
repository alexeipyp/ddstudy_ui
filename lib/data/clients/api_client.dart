import 'package:ddstudy_ui/domain/models/user/user_activity.dart';
import 'package:ddstudy_ui/domain/models/user/user_profile.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET("/api/User/GetCurrentUserProfile")
  Future<UserProfile?> getCurrentUserProfile();

  @GET("/api/User/GetCurrentUserActivity")
  Future<UserActivity?> getCurrentUserActivity();
}
