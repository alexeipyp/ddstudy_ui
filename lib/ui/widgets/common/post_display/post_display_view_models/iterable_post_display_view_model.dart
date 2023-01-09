import 'package:ddstudy_ui/domain/enums/feed_type.dart';
import 'package:flutter/material.dart';

import '../../../../../data/services/data_service.dart';
import '../../../../../data/services/like_service.dart';
import '../../../../../data/services/sync_service.dart';
import '../../../../../domain/models/post/post_model.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../../../domain/models/user/user_activity.dart';
import '../../../../../utils/exceptions.dart';
import '../../../../navigation/app_tab_navigator.dart';
import 'post_display_view_model.dart';

part 'grid_post_display_view_model.dart';
part 'user_post_display_view_model.dart';

class IterablePostDisplayViewModel extends PostDisplayViewModel {
  final int postsUploadAmountPerSync;
  final FeedTypeEnum feedType;
  final _dataService = DataService();
  final _syncService = SyncService();
  final _likeService = LikeService();
  final lvc = ScrollController();
  IterablePostDisplayViewModel({
    required BuildContext context,
    required this.postsUploadAmountPerSync,
    required this.feedType,
  }) : super(context: context) {
    initializeScrollController();
  }

  List<PostModel>? _posts;
  List<PostModel>? get posts => _posts;
  set posts(List<PostModel>? val) {
    _posts = val;
    notifyListeners();
  }

  Map<int, int> pager = <int, int>{};
  Map<String, int> postIndexes = <String, int>{};
  bool isFeedEndReached = false;

  void asyncInit() async {
    asyncPostsLoading();
  }

  @override
  void onPageChanged(String postId, int pageIndex) {
    var listIndex = postIndexes[postId];
    if (listIndex != null) {
      pager[listIndex] = pageIndex;
      notifyListeners();
    }
  }

  @override
  PostModel getPostById(String postId) {
    var listIndex = postIndexes[postId];
    return posts![listIndex!];
  }

  void initPostIndexes() {
    postIndexes = <String, int>{};
    if (posts != null) {
      for (var i = 0; i < posts!.length; i++) {
        postIndexes.addAll({posts![i].id: i});
      }
    }
  }

  @override
  int? getPageIndex(String postId) {
    var listIndex = postIndexes[postId];
    return pager[listIndex];
  }

  void initializeScrollController() {
    lvc.addListener(() {
      var max = lvc.position.maxScrollExtent;
      var current = lvc.offset;
      var percent = (current / max * 100);
      if (percent > 80) {
        if (!isLoading && !isFeedEndReached) {
          isLoading = true;
          Future.delayed(const Duration(seconds: 1)).then((value) async {
            if (posts != null) {
              var upToDate = posts!.last.uploadDate;
              await refreshPosts(upToDate: upToDate);
              isLoading = false;
            }
          });
        }
      }
    });
  }

  @override
  void onLikeButtonPressed(String postId) async {
    await _likeService.likePost(postId);
    var refreshedPostStats = await _dataService.getPostStats(postId);
    if (refreshedPostStats != null) {
      var listIndex = postIndexes[postId];
      posts![listIndex!].stats = refreshedPostStats;
      notifyListeners();
    }
  }

  void asyncPostsLoading() async {
    isLoading = true;
    await refreshPosts();
    isLoading = false;
  }

  Future refreshPosts({DateTime? upToDate}) async {
    try {
      await syncPosts(upToDate: upToDate);
      if (upToDate != null) {
        var newPosts = await loadPostsFromDB(upToDate: upToDate);
        if (newPosts.isEmpty) {
          isFeedEndReached = true;
        }
        posts = <PostModel>[...posts!, ...newPosts];
      } else {
        posts = await loadPostsFromDB(upToDate: upToDate);
      }
      initPostIndexes();
    } on NoNetworkException {
      await displayError("нет сети");
    } on ServerException {
      await displayError("ошибка на сервере");
    }
  }

  Future syncPosts({DateTime? upToDate}) async => await _syncService
      .syncPosts(feedType, postsUploadAmountPerSync, upToDate: upToDate);

  Future<List<PostModel>> loadPostsFromDB({DateTime? upToDate}) async =>
      await _dataService.getFeed(feedType, postsUploadAmountPerSync,
          upToDate: upToDate);

  @override
  Future displayError(String errorText) async {
    errText = errorText;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      errText = null;
    });
  }

  @override
  void openPostInDetailedPage(String postId) {
    var listIndex = postIndexes[postId];
    var postAttachesLinks =
        posts![listIndex!].attaches.map((e) => e.attachLink).toList();
    Navigator.of(context).pushNamed(AppTabNavigatorRoutes.postDetailed,
        arguments: postAttachesLinks);
  }
}
