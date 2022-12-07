import 'package:ddstudy_ui/ui/roots/app.dart';
import 'package:ddstudy_ui/ui/roots/auth.dart';
import 'package:ddstudy_ui/ui/roots/loader.dart';
import 'package:ddstudy_ui/ui/roots/profile.dart';
import 'package:flutter/material.dart';

class NavigationRoutes {
  static const loader = "/";
  static const auth = "/auth";
  static const app = "/app";
  static const profile = "/app/profile";
}

class AppNavigator {
  static final key = GlobalKey<NavigatorState>();

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

  static void toProfile() {
    key.currentState?.pushNamed(
      NavigationRoutes.profile,
    );
  }

  static void back() {
    key.currentState?.pop();
  }

  static Route<dynamic>? onGeneratedRoutes(RouteSettings settings, context) {
    switch (settings.name) {
      case NavigationRoutes.loader:
        return PageRouteBuilder(
            pageBuilder: ((_, __, ___) => LoaderWidget.create()));
      case NavigationRoutes.auth:
        return PageRouteBuilder(pageBuilder: ((_, __, ___) => Auth.create()));
      case NavigationRoutes.app:
        return PageRouteBuilder(
          pageBuilder: ((_, __, ___) => App.create()),
        );
      case NavigationRoutes.profile:
        return PageRouteBuilder(
          pageBuilder: ((_, __, ___) => Profile.create()),
        );
    }
    return null;
  }
}