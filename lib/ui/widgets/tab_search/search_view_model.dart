import 'package:flutter/material.dart';

import '../../../domain/enums/feed_type.dart';
import '../common/post_display/post_display_view_models/grid_post_display_view_model.dart';

class SearchViewModel extends GridPostDisplayViewModel {
  SearchViewModel(BuildContext context)
      : super(
          context: context,
          feedType: FeedTypeEnum.searchFeed,
          postsUploadAmountPerSync: 10,
        );
}
