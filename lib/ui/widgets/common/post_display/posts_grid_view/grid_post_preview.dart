import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';
import 'package:provider/provider.dart';

import '../../../../../internal/config/app_config.dart';
import '../post_display_view_models/post_display_view_model.dart';

class GridPostPreview<T extends PostDisplayViewModel> extends StatelessWidget {
  final String postId;
  const GridPostPreview({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel;
    viewModel = context.watch<T>();
    var post = viewModel.getPostById(postId);
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              "$AppConfig.baseUrl${post.attaches[0].attachLink}",
              cacheManager: DioCacheManager.instance,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
