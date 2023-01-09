import 'package:flutter/material.dart';

enum ContentTypeEnum { subscribe, search, favorite, comments, userPosts }

class ContentEnums {
  static Map<ContentTypeEnum, IconData> contentTypeIcon = {
    ContentTypeEnum.subscribe: Icons.home,
    ContentTypeEnum.search: Icons.search,
    ContentTypeEnum.favorite: Icons.favorite,
    ContentTypeEnum.comments: Icons.three_p_sharp,
    ContentTypeEnum.userPosts: Icons.photo,
  };

  static Map<ContentTypeEnum, String> contentTypeText = {
    ContentTypeEnum.subscribe:
        "Здесь отобразятся публикации тех, на кого подпишитесь",
    ContentTypeEnum.search: "Нет новых публикаций :(",
    ContentTypeEnum.favorite: "Здесь отобразятся любимые публикации",
    ContentTypeEnum.comments: "Пока нет комментариев...",
    ContentTypeEnum.userPosts: "Не видно публикаций :(",
  };
}
