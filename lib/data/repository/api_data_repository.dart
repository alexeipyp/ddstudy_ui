import 'dart:io';

import 'package:ddstudy_ui/data/clients/auth_client.dart';
import 'package:ddstudy_ui/domain/models/comment/comment_post_request.dart';
import 'package:ddstudy_ui/domain/models/comment/comment_stats.dart';
import 'package:ddstudy_ui/domain/models/comment/comment_model.dart';
import 'package:ddstudy_ui/domain/models/post/create_post_request.dart';
import 'package:ddstudy_ui/domain/models/post/like_post_request.dart';
import 'package:ddstudy_ui/domain/models/post/post_model.dart';
import 'package:ddstudy_ui/domain/models/subscribe/follow_user_request.dart';
import 'package:ddstudy_ui/domain/models/subscribe/undo_follow_user_request.dart';
import 'package:ddstudy_ui/domain/models/token/refresh_token_request.dart';
import 'package:ddstudy_ui/domain/models/token/token_request.dart';
import 'package:ddstudy_ui/domain/models/token/token_response.dart';
import 'package:ddstudy_ui/domain/models/user/register_user_request.dart';
import 'package:ddstudy_ui/domain/models/user/subscribe_status.dart';
import 'package:ddstudy_ui/domain/models/user/user.dart';
import 'package:ddstudy_ui/domain/models/user/user_activity_model.dart';
import 'package:ddstudy_ui/domain/repository/api_repository.dart';

import '../../domain/models/attach/attach_meta.dart';
import '../../domain/models/comment/like_comment_request.dart';
import '../../domain/models/post/post_stats.dart';
import '../clients/api_client.dart';

class ApiDataRepository extends ApiRepository {
  final AuthClient _auth;
  final ApiClient _api;
  ApiDataRepository(this._auth, this._api);

  @override
  Future<TokenResponse?> getToken({
    required String login,
    required String password,
  }) async {
    return await _auth.getToken(TokenRequest(login: login, password: password));
  }

  @override
  Future<User?> getUser() => _api.getCurrentUser();

  @override
  Future<UserActivityModel?> getUserActivity(String userId) =>
      _api.getUserActivity(userId);

  @override
  Future<TokenResponse?> refreshToken(String refreshToken) async =>
      await _auth.refreshToken(RefreshTokenRequest(
        refreshToken: refreshToken,
      ));

  @override
  Future<List<PostModel>> getFeed(int take, {DateTime? upTo}) =>
      _api.getFeed(take, upTo: upTo?.toIso8601String());

  @override
  Future<List<AttachMeta>> uploadTemp({required List<File> files}) =>
      _api.uploadTemp(files: files);

  @override
  Future addAvatarToUser(AttachMeta model) => _api.addAvatarToUser(model);

  @override
  Future registerUser({
    required String name,
    required String email,
    required String password,
    required String retryPassword,
    required DateTime birthDate,
  }) =>
      _auth.registerUser(RegisterUserRequest(
        name: name,
        email: email,
        password: password,
        retryPassword: retryPassword,
        birthDate: birthDate.toUtc().toIso8601String(),
      ));

  @override
  Future createPost(String annotation, List<AttachMeta> attaches) =>
      _api.createPost(CreatePostRequest(
        annotation: annotation,
        attaches: attaches,
      ));

  @override
  Future<PostStats?> likePost(String postId) => _api.likePost(
        LikePostRequest(postId: postId),
      );

  @override
  Future<List<PostModel>> getFavoritePosts(int take, {DateTime? upTo}) =>
      _api.getFavoritePosts(take, upTo: upTo?.toIso8601String());

  @override
  Future<List<PostModel>> getSubscriptionsFeed(int take, {DateTime? upTo}) =>
      _api.getSubscriptionsFeed(take, upTo: upTo?.toIso8601String());

  @override
  Future<List<PostModel>> getUserPosts(String userId, int take,
          {DateTime? upTo}) =>
      _api.getUserPosts(userId, take, upTo: upTo?.toIso8601String());

  @override
  Future commentPost(String postId, String text) => _api.commentPost(
        CommentPostRequest(postId: postId, text: text),
      );

  @override
  Future<List<CommentModel>> getComments(String postId, int take,
          {DateTime? upTo}) =>
      _api.getComments(postId, take, upTo: upTo?.toIso8601String());

  @override
  Future<CommentStats?> likeComment(String commentId) =>
      _api.likeComment(LikeCommentRequest(commentId: commentId));

  @override
  Future<SubscribeStatus?> followUser(String authorId) =>
      _api.followUser(FollowUserRequest(authorId: authorId));

  @override
  Future<SubscribeStatus?> undoFollowUser(String authorId) =>
      _api.undoFollowUser(UndoFollowUserRequest(authorId: authorId));

  @override
  Future<PostStats?> getPostStats(String postId) => _api.getPostStats(postId);
}
