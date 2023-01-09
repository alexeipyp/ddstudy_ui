import 'dart:io';

import 'package:ddstudy_ui/ui/widgets/common/cam_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/data_service.dart';
import '../../../data/services/sync_service.dart';
import '../../../domain/enums/tab_item.dart';
import '../../../internal/config/shared_prefs.dart';
import '../../../internal/dependencies/repository_module.dart';
import '../common/post_display/post_display_view_models/iterable_post_display_view_model.dart';
import '../roots/app.dart';

class CurrentUserProfileViewModel extends UserPostDisplayViewModel {
  final _api = RepositoryModule.apiRepository();
  final _dataService = DataService();
  final _syncService = SyncService();
  CurrentUserProfileViewModel({required BuildContext context})
      : super(
          context: context,
          postsUploadAmountPerSync: 10,
        ) {
    var appmodel = context.read<AppViewModel>();
    appmodel.addListener(() {
      avatar = appmodel.avatar;
    });
    appmodel.addListener(() {
      if (appmodel.currentTab == _currentTab) {
        if (!_isInitialized) {
          _isInitialized = true;
          asyncInit();
        }
      }
    });
  }

  final _currentTab = TabItemEnum.profile;
  bool _isInitialized = false;

  @override
  void asyncInit() async {
    user = await SharedPrefs.getStoredUser();
    if (user != null) {
      await _syncService.syncUserActivity(user!.id);
      userActivity = await _dataService.getUserActivity(user!.id);
    }
    asyncPostsLoading();
    initializeScrollController();
  }

  Future changePhoto() async {
    String? imagePath;
    var appmodel = context.read<AppViewModel>();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((newContext) => Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: CamWidget(
                  onFile: (file) {
                    imagePath = file.path;
                    Navigator.of(newContext).pop();
                  },
                ),
              ),
            )),
      ),
    );
    if (imagePath != null) {
      var temp = await _api.uploadTemp(files: [File(imagePath!)]);
      if (temp.isNotEmpty) {
        await _api.addAvatarToUser(temp.first);
        appmodel.refreshAvatar();
      }
    }
  }
}
