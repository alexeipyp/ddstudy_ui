import 'package:cached_network_image/cached_network_image.dart';
import 'package:ddstudy_ui/ui/widgets/common/post_display/post_display_view_models/post_display_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';
import 'package:provider/provider.dart';

import '../../../../../internal/config/app_config.dart';

class PostAuthorPreview<T extends PostDisplayViewModel>
    extends StatelessWidget {
  final String authorId;
  final String authorName;
  final String? avatarLink;
  const PostAuthorPreview({
    Key? key,
    required this.authorName,
    required this.authorId,
    this.avatarLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel;
    viewModel = context.watch<T>();
    return GestureDetector(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              "$baseUrl$avatarLink",
              cacheManager: DioCacheManager.instance,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(authorName),
          ),
        ],
      ),
      onTap: () {
        viewModel.openAuthorProfilePage(authorId);
      },
    );
  }
}
