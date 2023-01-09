import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums/feed_type.dart';
import '../../../../domain/enums/tab_item.dart';
import '../../common/post_display/post_display_view_models/iterable_post_display_view_model.dart';
import '../../roots/app.dart';

class HomeViewModel extends IterablePostDisplayViewModel {
  HomeViewModel(BuildContext context)
      : super(
          context: context,
          feedType: FeedTypeEnum.subscribeFeed,
          postsUploadAmountPerSync: 10,
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

  final _currentTab = TabItemEnum.home;
  bool _isInitialized = false;
}
