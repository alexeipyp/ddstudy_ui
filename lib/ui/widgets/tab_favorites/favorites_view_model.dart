import 'package:ddstudy_ui/domain/enums/feed_type.dart';
import 'package:ddstudy_ui/domain/enums/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/post_display/post_display_view_models/iterable_post_display_view_model.dart';
import '../roots/app.dart';

class FavoriteViewModel extends GridPostDisplayViewModel {
  FavoriteViewModel(BuildContext context)
      : super(
          context: context,
          feedType: FeedTypeEnum.favoritePosts,
          postsUploadAmountPerSync: 30,
        ) {
    var appmodel = context.read<AppViewModel>();
    appmodel.addListener(() {
      if (appmodel.currentTab == _currentTab) {
        if (!_isInitialized) {
          _isInitialized = true;
          asyncInit();
        }
      }
    });
  }

  final _currentTab = TabItemEnum.favorites;
  bool _isInitialized = false;
}
