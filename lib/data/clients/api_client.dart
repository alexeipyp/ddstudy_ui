import 'dart:io';

import 'package:ddstudy_ui/domain/models/attach/attach_meta.dart';
import 'package:ddstudy_ui/domain/models/comment/comment_post_request.dart';
import 'package:ddstudy_ui/domain/models/comment/like_comment_request.dart';
import 'package:ddstudy_ui/domain/models/post/create_post_request.dart';
import 'package:ddstudy_ui/domain/models/post/like_post_request.dart';
import 'package:ddstudy_ui/domain/models/post/post_stats.dart';
import 'package:ddstudy_ui/domain/models/user/user_activity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/models/comment/comment_model.dart';
import '../../domain/models/comment/comment_stats.dart';
import '../../domain/models/post/post_model.dart';
import '../../domain/models/user/user.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET("/api/User/GetCurrentUser")
  Future<User?> getCurrentUser();

  @GET("/api/User/GetUserActivity")
  Future<UserActivity?> getUserActivity(@Query("userId") String userId);

  @GET("/api/Post/GetFeed")
  Future<List<PostModel>> getFeed(@Query("take") int take,
      {@Query("upTo") String? upTo});

  @GET("/api/Post/GetSubscriptionsFeed")
  Future<List<PostModel>> getSubscriptionsFeed(@Query("take") int take,
      {@Query("upTo") String? upTo});

  @GET("/api/Post/GetFavoritePosts")
  Future<List<PostModel>> getFavoritePosts(@Query("take") int take,
      {@Query("upTo") String? upTo});

  @GET("/api/Post/GetUserPosts")
  Future<List<PostModel>> getUserPosts(
      @Query("userToVisitId") String userId, @Query("take") int take,
      {@Query("upTo") String? upTo});

  @POST("/api/Attach/UploadFiles")
  Future<List<AttachMeta>> uploadTemp(
      {@Part(name: "files") required List<File> files});

  @POST('/api/User/AddAvatarToUser')
  Future addAvatarToUser(@Body() AttachMeta model);

  @POST('/api/Post/CreatePost')
  Future createPost(@Body() CreatePostRequest request);

  @POST('/api/Like/LikePost')
  Future<PostStats?> likePost(@Body() LikePostRequest request);

  @GET("/api/Post/GetComments")
  Future<List<CommentModel>> getComments(
      @Query("postId") String postId, @Query("take") int take,
      {@Query("upTo") String? upTo});

  @POST('/api/Post/LikeComment')
  Future<CommentStats?> likeComment(@Body() LikeCommentRequest request);

  @POST('/api/Post/CommentPost')
  Future commentPost(@Body() CommentPostRequest request);
}
