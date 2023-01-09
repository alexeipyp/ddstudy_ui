import 'package:ddstudy_ui/ui/widgets/tab_favorites/favorites_widget.dart';
import 'package:ddstudy_ui/ui/widgets/tab_post/post_widget.dart';
import 'package:flutter/material.dart';

import '../../ui/widgets/tab_home/home/home_widget.dart';
import '../../ui/widgets/tab_profile/profile_widget.dart';
import '../../ui/widgets/tab_search/search_widget.dart';

enum TabItemEnum { home, search, post, favorites, profile }

class TabEnums {
  static const TabItemEnum defTab = TabItemEnum.home;

  static Map<TabItemEnum, IconData> tabIcon = {
    TabItemEnum.home: Icons.home_outlined,
    TabItemEnum.search: Icons.search_outlined,
    TabItemEnum.post: Icons.add_photo_alternate_outlined,
    TabItemEnum.favorites: Icons.favorite_outline,
    TabItemEnum.profile: Icons.person_outline,
  };

  static Map<TabItemEnum, IconData> selectedTabIcon = {
    TabItemEnum.home: Icons.home,
    TabItemEnum.search: Icons.search,
    TabItemEnum.post: Icons.add_photo_alternate,
    TabItemEnum.favorites: Icons.favorite,
    TabItemEnum.profile: Icons.person,
  };

  static Map<TabItemEnum, Widget> tabRoots = {
    TabItemEnum.home: HomeWidget.create(),
    TabItemEnum.search: SearchWidget.create(),
    TabItemEnum.post: CreatePostWidget.create(),
    TabItemEnum.favorites: FavoriteWidget.create(),
    TabItemEnum.profile: CurrentUserProfileWidget.create(),
  };
}
