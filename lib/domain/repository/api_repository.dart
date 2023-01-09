import 'dart:io';

import 'package:ddstudy_ui/domain/models/post/post_stats.dart';
import 'package:ddstudy_ui/domain/models/user/user.dart';

import '../models/attach/attach_meta.dart';
import '../models/comment/comment_model.dart';
import '../models/comment/comment_stats.dart';
import '../models/post/post_model.dart';
import '../models/token/token_response.dart';
import '../models/user/user_activity.dart';

abstract class ApiRepository {
  Future<TokenResponse?> getToken({
    required String login,
    required String password,
  });

  Future<TokenResponse?> refreshToken(String refreshToken);
  Future<User?> getUser();
  Future<UserActivity?> getUserActivity(String userId);
  Future<List<PostModel>> getFeed(int take, {DateTime? upTo});
  Future<List<PostModel>> getSubscriptionsFeed(int take, {DateTime? upTo});
  Future<List<PostModel>> getFavoritePosts(int take, {DateTime? upTo});
  Future<List<PostModel>> getUserPosts(String userId, int take,
      {DateTime? upTo});
  Future<List<AttachMeta>> uploadTemp({required List<File> files});
  Future addAvatarToUser(AttachMeta model);
  Future registerUser({
    required String name,
    required String email,
    required String password,
    required String retryPassword,
    required DateTime birthDate,
  });
  Future createPost(String annotation, List<AttachMeta> attaches);
  Future<PostStats?> likePost(String postId);
  Future<List<CommentModel>> getComments(String postId, int take,
      {DateTime? upTo});
  Future<CommentStats?> likeComment(String commentId);
  Future commentPost(String postId, String text);
}
