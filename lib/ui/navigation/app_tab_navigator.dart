import 'package:ddstudy_ui/domain/enums/app_tab_item.dart';
import 'package:flutter/material.dart';

class AppTabNavigatorRoutes {
  static const String root = '/app/';
  static const String postDetailed = "/app/postDetailed";
}

class AppTabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final AppTabItemEnum tabItem;
  const AppTabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.tabItem,
  }) : super(key: key);

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
          {Object? arg}) =>
      {
        AppTabNavigatorRoutes.root: (context) =>
            AppTabEnums.tabRoots[tabItem] ??
            SafeArea(
              child: Text(tabItem.name),
            ),
        //TabNavigatorRoutes.postDetailed: (context) => PostDetail.create(arg),
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
