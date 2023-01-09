import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/enums/feed_type.dart';
import '../../../domain/enums/tab_item.dart';
import '../../../internal/config/app_config.dart';
import '../common/post_display/post_display_view_models/iterable_post_display_view_model.dart';
import '../roots/app.dart';

class SearchViewModel extends GridPostDisplayViewModel {
  SearchViewModel(BuildContext context)
      : super(
          context: context,
          feedType: FeedTypeEnum.searchFeed,
          postsUploadAmountPerSync: AppConfig.gridViewPostsUploadAmountPerSync,
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

  final _currentTab = TabItemEnum.search;
  bool _isInitialized = false;
}
