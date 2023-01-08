import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';
import 'package:provider/provider.dart';

import '../../../../../internal/config/app_config.dart';
import 'post_detailed_view_model.dart';

class PostAttachInteractive extends StatelessWidget {
  final String attachLink;
  final int pageIndex;
  const PostAttachInteractive({
    Key? key,
    required this.attachLink,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<PostDetailedViewModel>();
    return InteractiveViewer(
      onInteractionEnd: (details) {
        viewModel.checkScrollLockCondition(pageIndex);
      },
      transformationController: viewModel.zoomControllers[pageIndex],
      child: CachedNetworkImage(
        imageUrl: "$baseUrl$attachLink",
        cacheManager: DioCacheManager.instance,
      ),
    );
  }
}
