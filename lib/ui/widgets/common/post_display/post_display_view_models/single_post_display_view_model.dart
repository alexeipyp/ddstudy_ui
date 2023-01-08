import 'package:flutter/material.dart';

import '../../../../../data/services/data_service.dart';
import '../../../../../data/services/like_service.dart';
import '../../../../../domain/models/post/post_model.dart';
import '../../../../navigation/app_tab_navigator.dart';
import 'post_display_view_model.dart';

class SinglePostDisplayViewModel extends PostDisplayViewModel {
  final String postId;
  final _dataService = DataService();
  final _likeService = LikeService();
  SinglePostDisplayViewModel({
    required BuildContext context,
    required this.postId,
  }) : super(context: context) {
    asyncPostLoading();
  }

  PostModel? _post;
  PostModel? get post => _post;
  set post(PostModel? val) {
    _post = val;
    notifyListeners();
  }

  int _pageIndex = 0;

  @override
  void onPageChanged(String postId, int pageIndex) {
    _pageIndex = pageIndex;
    notifyListeners();
  }

  @override
  PostModel getPostById(String postId) {
    return post!;
  }

  @override
  int? getPageIndex(String postId) {
    return _pageIndex;
  }

  @override
  void onLikeButtonPressed(String postId) async {
    await _likeService.likePost(postId);
    var refreshedPostStats = await _dataService.getPostStats(postId);
    if (refreshedPostStats != null) {
      post!.stats = refreshedPostStats;
      notifyListeners();
    }
  }

  void asyncPostLoading() async {
    isLoading = true;
    post = await _dataService.getPost(postId);
    isLoading = false;
  }

  @override
  Future displayError(String errorText) async {
    errText = errorText;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      errText = null;
    });
  }

  @override
  void openPostInDetailedPage(String postId) {
    var postAttachesLinks = post!.attaches.map((e) => e.attachLink).toList();
    Navigator.of(context).pushNamed(AppTabNavigatorRoutes.postDetailed,
        arguments: postAttachesLinks);
  }
}
