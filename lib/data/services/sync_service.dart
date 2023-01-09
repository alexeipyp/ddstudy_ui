import 'dart:io';

import 'package:ddstudy_ui/data/services/data_service.dart';
import 'package:ddstudy_ui/domain/models/post/post_searched.dart';
import 'package:ddstudy_ui/domain/models/post/post_subscribed.dart';
import 'package:ddstudy_ui/internal/dependencies/repository_module.dart';
import 'package:dio/dio.dart';

import '../../domain/enums/feed_type.dart';
import '../../domain/models/comment/comment.dart';
import '../../domain/models/comment/comment_model.dart';
import '../../domain/models/post/post.dart';
import '../../domain/models/post/post_model.dart';
import '../../domain/repository/api_repository.dart';
import '../../utils/exceptions.dart';

class SyncService {
  final ApiRepository _api = RepositoryModule.apiRepository();
  final DataService _dataService = DataService();

  Future syncUserActivity(String userId) async {
    var userActivity = await _api.getUserActivity(userId);
    if (userActivity != null) {
      userActivity = userActivity.copyWith(id: userId);
      _dataService.updateEntity(userActivity);
    }
  }

  Future syncComments(String postId, int take, {DateTime? upToDate}) async {
    try {
      List<CommentModel> commentModels;
      commentModels = await _api.getComments(postId, take, upTo: upToDate);
      moveCommentModelsToDB(commentModels, postId);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw NoNetworkException();
      } else {
        if (e.response?.statusCode == 500) {
          throw ServerException();
        }
      }
    }
  }

  Future syncPosts(FeedTypeEnum type, int take,
      {DateTime? upToDate, String? userId}) async {
    try {
      List<PostModel> postModels;
      switch (type) {
        case FeedTypeEnum.subscribeFeed:
          postModels = await _api.getSubscriptionsFeed(take, upTo: upToDate);
          if (upToDate == null) {
            await _dataService.erasePostSubscribedLabels();
          }
          await labelSubscribedFeed(postModels);
          break;
        case FeedTypeEnum.searchFeed:
          postModels = await _api.getFeed(take, upTo: upToDate);
          if (upToDate == null) {
            await _dataService.erasePostSearchedLabels();
          }
          await labelSearchFeed(postModels);
          break;
        case FeedTypeEnum.favoritePosts:
          postModels = await _api.getFavoritePosts(take, upTo: upToDate);
          break;
        case FeedTypeEnum.userPosts:
          postModels = await _api.getUserPosts(userId!, take, upTo: upToDate);
          break;
      }
      await movePostModelsToDB(postModels);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw NoNetworkException();
      } else {
        if (e.response?.statusCode == 500) {
          throw ServerException();
        }
      }
    }
  }

  Future moveCommentModelsToDB(
      List<CommentModel> commentModels, String postId) async {
    var authors = commentModels.map((e) => e.author).toSet();
    var commentStats =
        commentModels.map((e) => e.stats.copyWith(id: e.id)).toList();
    var comments = commentModels
        .map((e) => Comment.fromJson(e.toJson()).copyWith(
              authorId: e.author.id,
              postId: postId,
            ))
        .toList();

    await _dataService.rangeUpdateEntities(authors);
    await _dataService.rangeUpdateEntities(comments);
    await _dataService.rangeUpdateEntities(commentStats);
  }

  Future movePostModelsToDB(List<PostModel> postModels) async {
    var authors = postModels.map((e) => e.author).toSet();
    var postAttaches = postModels
        .expand((x) => x.attaches.map((e) => e.copyWith(postId: x.id)))
        .toList();
    var postStats = postModels.map((e) => e.stats.copyWith(id: e.id)).toList();
    var posts = postModels
        .map((e) => Post.fromJson(e.toJson()).copyWith(authorId: e.author.id))
        .toList();

    await _dataService.rangeUpdateEntities(authors);
    await _dataService.rangeUpdateEntities(posts);
    await _dataService.rangeUpdateEntities(postAttaches);
    await _dataService.rangeUpdateEntities(postStats);
  }

  Future labelSubscribedFeed(List<PostModel> postModels) async {
    var subscribeLabels =
        postModels.map((e) => PostSubscribed(id: e.id)).toList();
    await _dataService.rangeUpdateEntities(subscribeLabels);
  }

  Future labelSearchFeed(List<PostModel> postModels) async {
    var searchLabels = postModels.map((e) => PostSearched(id: e.id)).toList();
    await _dataService.rangeUpdateEntities(searchLabels);
  }
}
