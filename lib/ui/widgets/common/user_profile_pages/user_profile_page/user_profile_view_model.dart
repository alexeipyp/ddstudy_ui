import 'package:ddstudy_ui/data/services/subscribe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';

import '../../../../../data/services/data_service.dart';
import '../../../../../data/services/sync_service.dart';
import '../../../../../internal/config/app_config.dart';
import '../../post_display/post_display_view_models/iterable_post_display_view_model.dart';

class UserProfileViewModel extends UserPostDisplayViewModel {
  final _dataService = DataService();
  final _syncService = SyncService();
  final _subService = SubscribeService();
  final String authorId;
  UserProfileViewModel({required BuildContext context, required this.authorId})
      : super(
          context: context,
          postsUploadAmountPerSync: 10,
        ) {
    asyncInit();
  }

  @override
  void asyncInit() async {
    user = await _dataService.getUser(authorId);
    if (user != null) {
      await _syncService.syncUserActivity(user!.id);
      userActivity = await _dataService.getUserActivity(user!.id);
      subscribeStatus = await _dataService.getSubscribeStatus(user!.id);
    }
    getAuthorAvatar();
    asyncPostsLoading();
    initializeScrollController();
  }

  void getAuthorAvatar() async {
    if (user!.avatarLink != null) {
      var avatarFile = await DioCacheManager.instance
          .getSingleFile("$baseUrl${user!.avatarLink}");
      avatar = Image.file(avatarFile);
    }
  }

  @override
  void onFollowUserButtonClicked() async {
    await _subService.followUser(authorId);
    subscribeStatus = await _dataService.getSubscribeStatus(authorId);
  }

  @override
  void onUndoFollowUserButtonClicked() async {
    await _subService.undoFollowUser(authorId);
    subscribeStatus = await _dataService.getSubscribeStatus(authorId);
  }
}
