import 'package:ddstudy_ui/domain/db_model.dart';
import 'package:ddstudy_ui/domain/models/post/post_model.dart';
import 'package:ddstudy_ui/domain/models/post/post_searched.dart';
import 'package:ddstudy_ui/domain/models/post/post_stats.dart';
import 'package:ddstudy_ui/domain/models/post/post_subscribed.dart';
import 'package:ddstudy_ui/domain/models/user/user_activity.dart';

import '../../domain/enums/feed_type.dart';
import '../../domain/models/comment/comment.dart';
import '../../domain/models/comment/comment_model.dart';
import '../../domain/models/comment/comment_stats.dart';
import '../../domain/models/post/post.dart';
import '../../domain/models/post/post_attach.dart';
import '../../domain/models/user/user.dart';
import 'database.dart';

class DataService {
  Future cuUser(User user) async {
    await DB.instance.createUpdate(user);
  }

  Future<User?> getUser(String userId) async {
    var res = await DB.instance.get<User>(userId);
    return res;
  }

  Future rangeUpdateEntities<T extends DBModel>(Iterable<T> elems) async {
    await DB.instance.createUpdateRange(elems);
  }

  Future updateEntity<T extends DBModel>(T elem) async {
    await DB.instance.createUpdate(elem);
  }

  Future eraseData() async {
    await DB.instance.cleanTable<Post>();
    await DB.instance.cleanTable<PostStats>();
    await DB.instance.cleanTable<PostAttach>();
    await DB.instance.cleanTable<User>();
    await DB.instance.cleanTable<PostSearched>();
    await DB.instance.cleanTable<PostSubscribed>();
  }

  Future<List<PostSearched>> getPostSearchedLabels() async {
    var res = (await DB.instance.getAll<PostSearched>()).toList();
    return res;
  }

  Future erasePostSearchedLabels() async {
    await DB.instance.cleanTable<PostSearched>();
  }

  Future<List<PostSubscribed>> getPostSubscribedLabels() async {
    var res = (await DB.instance.getAll<PostSubscribed>()).toList();
    return res;
  }

  Future erasePostSubscribedLabels() async {
    await DB.instance.cleanTable<PostSubscribed>();
  }

  Future<UserActivity?> getUserActivity(String userId) async {
    var res = await DB.instance.get<UserActivity>(userId);
    return res;
  }

  Future<List<CommentModel>> getComments(String postId,
      {DateTime? upToDate, int? take}) async {
    var res = <CommentModel>[];
    Map<String, Object?>? whereMap = {"postId": postId};
    if (upToDate != null) {
      whereMap.addAll({
        "uploadDate": WhereCompareArg(
          arg: upToDate.toIso8601String(),
          compareOper: ComparisonOperatorEnum.greater,
        )
      });
    }
    var comments = await DB.instance.getAll<Comment>(
      orderBy: "uploadDate ASC",
      whereMap: whereMap,
      take: take,
    );

    for (var comment in comments) {
      var author = await DB.instance.get<User>(comment.authorId);
      var stats = await DB.instance.get<CommentStats>(comment.id);
      if (author != null && stats != null) {
        res.add(CommentModel(
          id: comment.id,
          author: author,
          text: comment.text,
          uploadDate: comment.uploadDate,
          stats: stats,
        ));
      }
    }
    return res;
  }

  Future<List<PostModel>> getFeed(FeedTypeEnum type, int take,
      {DateTime? upToDate, String? userId}) async {
    List<PostModel> res;
    switch (type) {
      case FeedTypeEnum.subscribeFeed:
        res = await getSubscriptionsFeed(take, upToDate: upToDate);
        break;
      case FeedTypeEnum.searchFeed:
        res = await getSearchFeed(take, upToDate: upToDate);
        break;
      case FeedTypeEnum.favoritePosts:
        res = await getFavoritePosts(take, upToDate: upToDate);
        break;
      case FeedTypeEnum.userPosts:
        res = await getUserPosts(userId!, take, upToDate: upToDate);
        break;
    }
    return res;
  }

  Future<List<PostModel>> getUserPosts(String userId, int take,
      {DateTime? upToDate}) async {
    return await _getPosts(FeedTypeEnum.userPosts, take,
        upToDate: upToDate, userId: userId);
  }

  Future<List<PostModel>> getSearchFeed(int take, {DateTime? upToDate}) async {
    return await _getPosts(FeedTypeEnum.searchFeed, take, upToDate: upToDate);
  }

  Future<List<PostModel>> getSubscriptionsFeed(int take,
      {DateTime? upToDate}) async {
    return await _getPosts(FeedTypeEnum.subscribeFeed, take,
        upToDate: upToDate);
  }

  Future<List<PostModel>> _getPosts(FeedTypeEnum type, int take,
      {DateTime? upToDate, String? userId}) async {
    var res = <PostModel>[];
    List<String> labels = <String>[];
    Map<String, Object?>? whereMap = {};
    switch (type) {
      case FeedTypeEnum.subscribeFeed:
        labels = (await getPostSubscribedLabels()).map((e) => e.id).toList();
        if (labels.isNotEmpty) {
          whereMap.addAll({"id": labels});
        } else {
          return res;
        }
        break;
      case FeedTypeEnum.searchFeed:
        labels = (await getPostSearchedLabels()).map((e) => e.id).toList();
        if (labels.isNotEmpty) {
          whereMap.addAll({"id": labels});
        } else {
          return res;
        }
        break;
      case FeedTypeEnum.favoritePosts:
        break;
      case FeedTypeEnum.userPosts:
        whereMap.addAll({"authorId": userId!});
        break;
    }
    if (upToDate != null) {
      whereMap.addAll({
        "uploadDate": WhereCompareArg(
          arg: upToDate.toString(),
          compareOper: ComparisonOperatorEnum.less,
        )
      });
    }
    var posts = await DB.instance.getAll<Post>(
      orderBy: "uploadDate DESC",
      whereMap: whereMap,
      take: take,
    );
    for (var post in posts) {
      var author = await DB.instance.get<User>(post.authorId);
      var attaches =
          (await DB.instance.getAll<PostAttach>(whereMap: {"postId": post.id}))
              .toList();
      var stats = await DB.instance.get<PostStats>(post.id);
      if (author != null && stats != null) {
        res.add(PostModel(
          id: post.id,
          author: author,
          attaches: attaches,
          annotation: post.annotation,
          uploadDate: post.uploadDate,
          stats: stats,
        ));
      }
    }
    return res;
  }

  Future<List<PostModel>> getFavoritePosts(int take,
      {DateTime? upToDate}) async {
    var res = <PostModel>[];
    Map<String, Object?>? whereMap = {
      "whenLiked":
          WhereNullCheckArg(nullCheckOper: NullCheckOperatorEnum.isNotNull)
    };
    if (upToDate != null) {
      whereMap.addAll({
        "whenLiked": WhereCompareArg(
          arg: upToDate.toString(),
          compareOper: ComparisonOperatorEnum.less,
        )
      });
    }
    var postStats = await DB.instance.getAll<PostStats>(
      orderBy: "whenLiked DESC",
      whereMap: whereMap,
      take: take,
    );

    for (var stats in postStats) {
      var post = await DB.instance.get<Post>(stats.id);
      if (post != null) {
        var author = await DB.instance.get<User>(post.authorId);
        var attaches = (await DB.instance
                .getAll<PostAttach>(whereMap: {"postId": post.id}))
            .toList();
        if (author != null) {
          res.add(PostModel(
            id: post.id,
            author: author,
            attaches: attaches,
            annotation: post.annotation,
            uploadDate: post.uploadDate,
            stats: stats,
          ));
        }
      }
    }
    return res;
  }

  Future<PostStats?> getPostStats(String postId) async {
    var res = await DB.instance.get<PostStats>(postId);
    return res;
  }

  Future<CommentStats?> getCommentStats(String commentId) async {
    var res = await DB.instance.get<CommentStats>(commentId);
    return res;
  }

  Future<PostModel?> getPost(String postId) async {
    PostModel? res;
    var post = await DB.instance.get<Post>(postId);
    if (post != null) {
      var author = await DB.instance.get<User>(post.authorId);
      var attaches =
          (await DB.instance.getAll<PostAttach>(whereMap: {"postId": post.id}))
              .toList();
      var stats = await DB.instance.get<PostStats>(post.id);
      if (author != null && stats != null) {
        res = PostModel(
          id: post.id,
          author: author,
          attaches: attaches,
          annotation: post.annotation,
          uploadDate: post.uploadDate,
          stats: stats,
        );
      }
    }

    return res;
  }
}
