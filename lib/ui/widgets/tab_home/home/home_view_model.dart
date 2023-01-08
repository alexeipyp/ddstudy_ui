import 'package:flutter/material.dart';

import '../../../../domain/enums/feed_type.dart';
import '../../common/post_display/post_display_view_models/iterable_post_display_view_model.dart';

class HomeViewModel extends IterablePostDisplayViewModel {
  HomeViewModel(BuildContext context)
      : super(
          context: context,
          feedType: FeedTypeEnum.subscribeFeed,
          postsUploadAmountPerSync: 10,
        );
}
