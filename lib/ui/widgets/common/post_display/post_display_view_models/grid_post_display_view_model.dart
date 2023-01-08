import 'package:ddstudy_ui/domain/enums/feed_type.dart';
import 'package:flutter/material.dart';

import '../../../../navigation/app_tab_navigator.dart';
import 'iterable_post_display_view_model.dart';

class GridPostDisplayViewModel extends IterablePostDisplayViewModel {
  GridPostDisplayViewModel({
    required BuildContext context,
    required FeedTypeEnum feedType,
    required int postsUploadAmountPerSync,
  }) : super(
          context: context,
          feedType: feedType,
          postsUploadAmountPerSync: postsUploadAmountPerSync,
        );

  void openPostInSinglePage(String postId) {
    Navigator.of(context)
        .pushNamed(AppTabNavigatorRoutes.postAlone, arguments: postId);
  }
}
