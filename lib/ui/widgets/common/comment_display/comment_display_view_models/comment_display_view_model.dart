import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/enums/tab_item.dart';
import '../../../../../domain/models/comment/comment_model.dart';
import '../../../../../internal/config/shared_prefs.dart';
import '../../../../navigation/app_tab_navigator.dart';
import '../../../roots/app.dart';

abstract class CommentDisplayViewModel extends ChangeNotifier {
  BuildContext context;
  String postId;
  String? currentUserId;
  CommentDisplayViewModel({
    required this.context,
    required this.postId,
  }) {
    appModel = context.read<AppViewModel>();
    loadCurrentUser();
  }

  bool isLoading = false;
  AppViewModel? appModel;

  String? _errText;
  String? get errText => _errText;
  set errText(String? val) {
    _errText = val;
    notifyListeners();
  }

  void openAuthorProfilePage(String authorId) {
    if (currentUserId != null) {
      if (authorId == currentUserId) {
        appModel!.selectTab(TabItemEnum.profile);
      } else {
        Navigator.of(context).pushNamed(AppTabNavigatorRoutes.authorProfile,
            arguments: authorId);
      }
    }
  }

  Image? getCurrentUserAvatar() {
    if (appModel != null) {
      return appModel!.avatar;
    }
    return null;
  }

  CommentModel getCommentById(String commentId);

  void onLikeButtonPressed(String commentId);

  Future displayError(String errorText);

  Future loadCurrentUser() async {
    var user = await SharedPrefs.getStoredUser();
    if (user != null) {
      currentUserId = user.id;
    }
  }
}
