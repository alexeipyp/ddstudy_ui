import 'package:ddstudy_ui/ui/widgets/tab_post/post_widget.dart';
import 'package:flutter/material.dart';

import '../../ui/widgets/tab_home/home/home_widget.dart';
import '../../ui/widgets/tab_profile/profile_widget.dart';

enum AppTabItemEnum { home, search, post, favorites, profile }

class AppTabEnums {
  static const AppTabItemEnum defTab = AppTabItemEnum.home;

  static Map<AppTabItemEnum, IconData> tabIcon = {
    AppTabItemEnum.home: Icons.home_outlined,
    AppTabItemEnum.search: Icons.search_outlined,
    AppTabItemEnum.post: Icons.add_photo_alternate_outlined,
    AppTabItemEnum.favorites: Icons.favorite_outline,
    AppTabItemEnum.profile: Icons.person_outline,
  };

  static Map<AppTabItemEnum, IconData> selectedTabIcon = {
    AppTabItemEnum.home: Icons.home,
    AppTabItemEnum.search: Icons.search,
    AppTabItemEnum.post: Icons.add_photo_alternate,
    AppTabItemEnum.favorites: Icons.favorite,
    AppTabItemEnum.profile: Icons.person,
  };

  static Map<AppTabItemEnum, Widget> tabRoots = {
    AppTabItemEnum.home: HomeWidget.create(),
    AppTabItemEnum.search: const Center(child: Text("search")),
    AppTabItemEnum.post: CreatePostWidget.create(),
    AppTabItemEnum.favorites: const Center(child: Text("favorite posts")),
    AppTabItemEnum.profile: ProfileWidget.create(),
  };
}
