import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../data/services/auth_service.dart';
import '../../../domain/enums/app_tab_item.dart';
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

  final _navigationKeys = {
    AppTabItemEnum.home: GlobalKey<NavigatorState>(),
    AppTabItemEnum.search: GlobalKey<NavigatorState>(),
    AppTabItemEnum.post: GlobalKey<NavigatorState>(),
    AppTabItemEnum.favorites: GlobalKey<NavigatorState>(),
    AppTabItemEnum.profile: GlobalKey<NavigatorState>(),
  };

  var _currentTab = AppTabEnums.defTab;
  AppTabItemEnum? beforeTab;
  AppTabItemEnum get currentTab => _currentTab;
  void selectTab(AppTabItemEnum tabItemEnum) {
    if (tabItemEnum == _currentTab) {
      _navigationKeys[tabItemEnum]!
          .currentState!
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

  Image? _avatar;
  Image? get avatar => _avatar;
  set avatar(Image? val) {
    _avatar = val;
    notifyListeners();
  }

  void asyncInit() async {
    user = await SharedPrefs.getStoredUser();
    /*
    var img = await NetworkAssetBundle(Uri.parse("$baseUrl${user!.avatarLink}"))
        .load("$baseUrl${user!.avatarLink}?v=1");
    avatar = Image.memory(
      img.buffer.asUint8List(),
      fit: BoxFit.cover,
    );
    */
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
            var isFirstRouteInCurrentTab = !await viewModel
                ._navigationKeys[viewModel.currentTab]!.currentState!
                .maybePop();
            if (isFirstRouteInCurrentTab) {
              if (viewModel.currentTab != AppTabEnums.defTab) {
                viewModel.selectTab(AppTabEnums.defTab);
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
                children: AppTabItemEnum.values
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

  Widget _buildOffstageNavigator(BuildContext context, AppTabItemEnum tabItem) {
    var viewModel = context.watch<AppViewModel>();

    return Offstage(
      offstage: viewModel.currentTab != tabItem,
      child: AppTabNavigator(
        navigatorKey: viewModel._navigationKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
