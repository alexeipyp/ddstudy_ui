import 'package:ddstudy_ui/domain/enums/tab_item.dart';
import 'package:ddstudy_ui/ui/widgets/common/post_pages/single_post_page/single_post_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/common/post_pages/post_detailed_page/post_detailed_widget.dart';
import '../widgets/common/user_profile_pages/user_profile_page/user_profile_widget.dart';

class AppTabNavigatorRoutes {
  static const String root = '/app/';
  static const String postDetailed = "/app/postDetailed";
  static const String postAlone = "/app/postAlone";
  static const String authorProfile = "/app/authorProfile";
}

class AppTabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItemEnum tabItem;
  const AppTabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.tabItem,
  }) : super(key: key);

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
          {Object? arg}) =>
      {
        AppTabNavigatorRoutes.root: (context) =>
            TabEnums.tabRoots[tabItem] ??
            SafeArea(
              child: Text(tabItem.name),
            ),
        AppTabNavigatorRoutes.postAlone: (context) =>
            SinglePostWidget.create(arg),
        AppTabNavigatorRoutes.postDetailed: (context) =>
            PostDetailedWidget.create(arg),
        AppTabNavigatorRoutes.authorProfile: (context) =>
            UserProfileWidget.create(arg),
      };

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: AppTabNavigatorRoutes.root,
      onGenerateRoute: (settings) {
        var rb = _routeBuilders(context, arg: settings.arguments);
        if (rb.containsKey(settings.name)) {
          return MaterialPageRoute(
              builder: (context) => rb[settings.name]!(context));
        }

        return null;
      },
    );
  }
}
