import 'package:flutter/material.dart';
import '../../../../../domain/models/post/post_model.dart';

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

  void onPageChanged(String postId, int pageIndex);

  PostModel getPostById(String postId);

  int? getPageIndex(String postId);

  void onLikeButtonPressed(String postId);

  Future displayError(String errorText);
}
