import 'dart:io';

import 'package:ddstudy_ui/domain/models/attach/attach_meta.dart';
import 'package:ddstudy_ui/domain/models/post/create_post_request.dart';
import 'package:ddstudy_ui/domain/models/user/user_activity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/models/post/post_model.dart';
import '../../domain/models/user/user.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET("/api/User/GetCurrentUser")
  Future<User?> getCurrentUser();

  @GET("/api/User/GetCurrentUserActivity")
  Future<UserActivity?> getCurrentUserActivity();

  @GET("/api/Post/GetFeed")
  Future<List<PostModel>> getFeed(
      @Query("skip") int skip, @Query("take") int take);

  @POST("/api/Attach/UploadFiles")
  Future<List<AttachMeta>> uploadTemp(
      {@Part(name: "files") required List<File> files});

  @POST('/api/User/AddAvatarToUser')
  Future addAvatarToUser(@Body() AttachMeta model);

  @POST('/api/Post/CreatePost')
  Future createPost(@Body() CreatePostRequest request);
}
