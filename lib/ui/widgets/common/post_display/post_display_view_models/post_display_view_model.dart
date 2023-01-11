import 'package:flutter/material.dart';
import '../../../../../domain/models/post/post_model.dart';
import '../../../../navigation/app_tab_navigator.dart';

abstract class PostDisplayViewModel extends ChangeNotifier {
  BuildContext context;
  PostDisplayViewModel({
    required this.context,
  });

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
    Navigator.of(context)
        .pushNamed(AppTabNavigatorRoutes.authorProfile, arguments: authorId)
        .then((_) => refreshDisplayedPostsStats());
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
