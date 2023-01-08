import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';
import 'package:provider/provider.dart';

import '../../../data/services/auth_service.dart';
import '../../../domain/enums/tab_item.dart';
import '../../../domain/models/user/user.dart';
import '../../../internal/config/app_config.dart';
import '../../../internal/config/shared_prefs.dart';
import '../../navigation/global_navigator.dart';
import '../../navigation/app_tab_navigator.dart';
import '../common/app_bottom_tabs.dart';

class AppViewModel extends ChangeNotifier {
  BuildContext context;
  final _authService = AuthService();
  AppViewModel({required this.context}) {
    asyncInit();
  }

  var _currentTab = TabEnums.defTab;
  TabItemEnum? beforeTab;
  TabItemEnum get currentTab => _currentTab;
  void selectTab(TabItemEnum tabItemEnum) {
    if (tabItemEnum == _currentTab) {
      GlobalNavigator.navigationKeys[tabItemEnum]!.currentState!
          .popUntil((route) => route.isFirst);
    } else {
      beforeTab = _currentTab;
      _currentTab = tabItemEnum;
      notifyListeners();
    }
  }

  User? _user;
  User? get user => _user;
  set user(User? val) {
    _user = val;
    notifyListeners();
  }

  String avatarCacheKey = "avatar";
  Image? _avatar;
  Image? get avatar => _avatar;
  set avatar(Image? val) {
    _avatar = val;
    notifyListeners();
  }

  void asyncInit() async {
    user = await SharedPrefs.getStoredUser();
    await refreshAvatar();
  }

  Future refreshAvatar() async {
    if (user!.avatarLink != null) {
      await DioCacheManager.instance.downloadFile(
        "$baseUrl${user!.avatarLink}",
        key: avatarCacheKey,
        force: true,
      );
      var avatarFileInfo =
          await DioCacheManager.instance.getFileFromCache(avatarCacheKey);
      if (avatarFileInfo != null) {
        avatar = Image.file(avatarFileInfo.file);
      }
    }
  }

  void logout() async {
    await _authService.logout().then((value) => GlobalNavigator.toLoader());
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<AppViewModel>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
          onWillPop: () async {
            var isFirstRouteInCurrentTab = !await GlobalNavigator
                .navigationKeys[viewModel.currentTab]!.currentState!
                .maybePop();
            if (isFirstRouteInCurrentTab) {
              if (viewModel.currentTab != TabEnums.defTab) {
                viewModel.selectTab(TabEnums.defTab);
              }
              return false;
            }
            return isFirstRouteInCurrentTab;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Fluttergram.NET"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: viewModel.logout,
                ),
              ],
            ),
            bottomNavigationBar: AppBottomTabs(
              currentTab: viewModel.currentTab,
              onSelectTab: viewModel.selectTab,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: Stack(
                children: TabItemEnum.values
                    .map((e) => _buildOffstageNavigator(context, e))
                    .toList()),
          )),
    );
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppViewModel(context: context),
      child: const App(),
    );
  }

  Widget _buildOffstageNavigator(BuildContext context, TabItemEnum tabItem) {
    var viewModel = context.watch<AppViewModel>();

    return Offstage(
      offstage: viewModel.currentTab != tabItem,
      child: AppTabNavigator(
        navigatorKey: GlobalNavigator.navigationKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
