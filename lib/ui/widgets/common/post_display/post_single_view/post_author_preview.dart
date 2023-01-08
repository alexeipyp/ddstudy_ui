import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';

import '../../../../../internal/config/app_config.dart';

class PostAuthorPreview extends StatelessWidget {
  final String authorName;
  final String? avatarLink;
  const PostAuthorPreview({
    Key? key,
    required this.authorName,
    this.avatarLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
