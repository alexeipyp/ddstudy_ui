import 'package:ddstudy_ui/domain/enums/app_tab_item.dart';
import 'package:ddstudy_ui/ui/widgets/roots/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBottomTabs extends StatelessWidget {
  final AppTabItemEnum currentTab;
  final ValueChanged<AppTabItemEnum> onSelectTab;
  final Color backgroundColor;
  const AppBottomTabs({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppViewModel>();
    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: AppTabItemEnum.values.indexOf(currentTab),
      items: AppTabItemEnum.values.map((e) => _buildItem(e, appModel)).toList(),
      onTap: (value) {
        FocusScope.of(context).unfocus();
        onSelectTab(AppTabItemEnum.values[value]);
      },
    );
  }

  BottomNavigationBarItem _buildItem(
      AppTabItemEnum tabItem, AppViewModel appModel) {
    var isCurrent = currentTab == tabItem;
    var color = isCurrent ? Colors.red : Colors.black;
    var iconData = isCurrent
        ? AppTabEnums.selectedTabIcon[tabItem]
        : AppTabEnums.tabIcon[tabItem];
    var icon = Icon(
      iconData,
      color: color,
    );
    return BottomNavigationBarItem(
      label: "",
      backgroundColor: isCurrent ? Colors.grey : Colors.transparent,
      icon: icon,
    );
  }
}
