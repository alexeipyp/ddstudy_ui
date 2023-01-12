import 'package:ddstudy_ui/domain/enums/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../domain/models/post/post_model.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../../navigation/app_tab_navigator.dart';
import '../../../roots/app.dart';

abstract class PostDisplayViewModel extends ChangeNotifier {
  BuildContext context;
  PostDisplayViewModel({
    required this.context,
  }) {
    appModel = context.read<AppViewModel>();
    if (appModel!.user == null) {
      appModelListener() {
        currentUser = appModel!.user;
        if (currentUser != null) {
          appModel!.removeListener(appModelListener);
        }
      }

      appModel!.addListener(appModelListener);
    } else {
      currentUser = appModel!.user;
    }
  }

  AppViewModel? appModel;

  User? _currentUser;
  User? get currentUser => _currentUser;
  set currentUser(User? val) {
    _currentUser = val;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  String? _errText;
  String? get errText => _errText;
  set errText(String? val) {
    _errText = val;
    notifyListeners();
  }

  void openPostInDetailedPage(String postId);

  void openAuthorProfilePage(String authorId) {
    if (currentUser != null) {
      var currentUserId = appModel!.user!.id;
      if (authorId == currentUserId) {
        appModel!.selectTab(TabItemEnum.profile);
      } else {
        Navigator.of(context)
            .pushNamed(AppTabNavigatorRoutes.authorProfile, arguments: authorId)
            .then((_) => refreshDisplayedPostsStats());
      }
    }
  }

  Image? getCurrentUserAvatar() {
    if (appModel != null) {
      return appModel!.avatar;
    }
    return null;
  }

  void refreshDisplayedPostsStats();
  void syncPostStats(String postId);

  void onPageChanged(String postId, int pageIndex);

  PostModel getPostById(String postId);

  int? getPageIndex(String postId);

  void onLikeButtonPressed(String postId);

  void onCommentsButtonPressed(String postId) {
    Navigator.of(context)
        .pushNamed(AppTabNavigatorRoutes.postComments, arguments: postId)
        .then((_) => syncPostStats(postId));
  }

  Future displayError(String errorText);
}
