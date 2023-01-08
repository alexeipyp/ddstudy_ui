import 'package:ddstudy_ui/domain/enums/feed_type.dart';
import 'package:flutter/material.dart';

import '../common/post_display/post_display_view_models/grid_post_display_view_model.dart';

class FavoriteViewModel extends GridPostDisplayViewModel {
  FavoriteViewModel(BuildContext context)
      : super(
          context: context,
          feedType: FeedTypeEnum.favoritePosts,
          postsUploadAmountPerSync: 10,
        );
}
