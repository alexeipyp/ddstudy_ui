import 'package:ddstudy_ui/data/services/comment_service.dart';
import 'package:flutter/material.dart';

import '../../../../../internal/config/app_config.dart';
import '../../comment_display/comment_display_view_models/iterable_comment_display_view_model.dart';

class PostCommentsViewModel extends IterableCommentDisplayViewModel {
  PostCommentsViewModel(
    BuildContext context,
    String postId,
  ) : super(
          context: context,
          postId: postId,
          commentsUploadAmountPerSync: AppConfig.commentsUploadAmountPerSync,
          refreshInterval: const Duration(
            milliseconds: AppConfig.commentsRefreshRateInMilliseconds,
          ),
        );

  var commentTextTec = TextEditingController();
  final _commentService = CommentService();

  void sendComment() {
    if (commentTextTec.text.isNotEmpty) {
      _commentService.commentPost(postId, commentTextTec.text);
      commentTextTec.clear();
      if (lvc.hasClients) {
        lvc.animateTo(
          lvc.position.maxScrollExtent,
          duration: const Duration(milliseconds: 50),
          curve: Curves.linear,
        );
      }
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void scrollToEnd() {
    lvc.jumpTo(lvc.position.maxScrollExtent);
  }
}
