import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';

import '../../../../../internal/config/app_config.dart';

class PostAttachPreview extends StatelessWidget {
  final String attachLink;
  const PostAttachPreview({
    Key? key,
    required this.attachLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
            "$baseUrl$attachLink",
            cacheManager: DioCacheManager.instance,
          ),
        ),
      ),
    );
  }
}
