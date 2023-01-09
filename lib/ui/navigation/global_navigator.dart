import 'package:ddstudy_ui/ui/widgets/roots/app.dart';
import 'package:ddstudy_ui/ui/widgets/roots/auth.dart';
import 'package:ddstudy_ui/ui/widgets/roots/loader.dart';
import 'package:flutter/material.dart';

import '../../domain/enums/tab_item.dart';
import '../widgets/register/register_widget.dart';

class NavigationRoutes {
  static const loader = "/";
  static const auth = "/auth";
  static const app = "/app";
  static const register = "/auth/register";
}

class GlobalNavigator {
  static final key = GlobalKey<NavigatorState>();
  static final navigationKeys = {
    TabItemEnum.home: GlobalKey<NavigatorState>(),
    TabItemEnum.search: GlobalKey<NavigatorState>(),
    TabItemEnum.post: GlobalKey<NavigatorState>(),
    TabItemEnum.favorites: GlobalKey<NavigatorState>(),
    TabItemEnum.profile: GlobalKey<NavigatorState>(),
  };

  static void toLoader() async {
    key.currentState?.pushNamedAndRemoveUntil(
      NavigationRoutes.loader,
      (route) => false,
    );
  }

  static void toAuth() {
    key.currentState?.pushNamedAndRemoveUntil(
      NavigationRoutes.auth,
      (route) => false,
    );
  }

  static void toHome() {
    key.currentState?.pushNamedAndRemoveUntil(
      NavigationRoutes.app,
      (route) => false,
    );
  }

  static void toRegistration() {
    key.currentState?.pushNamed(
      NavigationRoutes.register,
    );
  }

  static void back() {
    key.currentState?.pop();
  }

  static Route<dynamic>? onGeneratedRoutes(RouteSettings settings, context) {
    switch (settings.name) {
      case NavigationRoutes.loader:
        return PageRouteBuilder(
          pageBuilder: ((_, __, ___) => LoaderWidget.create()),
        );
      case NavigationRoutes.auth:
        return PageRouteBuilder(
          pageBuilder: ((_, __, ___) => Auth.create()),
        );
      case NavigationRoutes.app:
        return PageRouteBuilder(
          pageBuilder: ((_, __, ___) => App.create()),
        );
      case NavigationRoutes.register:
        return PageRouteBuilder(
          pageBuilder: ((_, __, ___) => RegisterWidget.create()),
        );
    }
    return null;
  }
}
