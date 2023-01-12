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
      foregroundDecoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 3,
            color: Theme.of(context).primaryColor,
          ),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
            "${AppConfig.baseUrl}$attachLink",
            cacheManager: DioCacheManager.instance,
          ),
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.photo_camera_outlined,
          color: Colors.white,
          size: 200,
        ),
      ),
    );
  }
}
