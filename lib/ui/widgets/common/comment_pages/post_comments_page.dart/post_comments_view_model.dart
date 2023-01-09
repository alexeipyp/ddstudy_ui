import 'package:ddstudy_ui/data/services/comment_service.dart';
import 'package:flutter/material.dart';

import '../../comment_display/comment_display_view_models/iterable_comment_display_view_model.dart';

class PostCommentsViewModel extends IterableCommentDisplayViewModel {
  PostCommentsViewModel(
    BuildContext context,
    String postId,
  ) : super(
          context: context,
          postId: postId,
          commentsUploadAmountPerSync: 20,
          refreshInterval: const Duration(
            milliseconds: 500,
          ),
        );

  var commentTextTec = TextEditingController();
  final _commentService = CommentService();

  void sendComment() {
    if (commentTextTec.text.isNotEmpty) {
      _commentService.commentPost(postId, commentTextTec.text);
      commentTextTec.clear();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}
