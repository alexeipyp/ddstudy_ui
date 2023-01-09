import 'package:flutter/material.dart';

import '../../../../../domain/models/comment/comment_model.dart';
import '../../../../../internal/config/shared_prefs.dart';
import '../../../../navigation/app_tab_navigator.dart';

abstract class CommentDisplayViewModel extends ChangeNotifier {
  BuildContext context;
  String postId;
  String? currentUserId;
  CommentDisplayViewModel({
    required this.context,
    required this.postId,
  }) {
    loadCurrentUser();
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

  void openAuthorProfilePage(String authorId) {
    Navigator.of(context)
        .pushNamed(AppTabNavigatorRoutes.authorProfile, arguments: authorId);
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
