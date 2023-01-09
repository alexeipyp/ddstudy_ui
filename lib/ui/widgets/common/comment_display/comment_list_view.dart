import 'package:ddstudy_ui/ui/widgets/common/comment_display/comment_display_view_models/iterable_comment_display_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'comment_preview.dart';

class CommentListView<T extends IterableCommentDisplayViewModel>
    extends StatelessWidget {
  const CommentListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel = context.watch<T>();
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      controller: viewModel.lvc,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: ((listContext, listIndex) {
        Widget res;
        if (viewModel.comments != null) {
          res = CommentPreview<T>(
            commentId: viewModel.comments![listIndex].id,
          );
        } else {
          res = const SizedBox.shrink();
        }
        return res;
      }),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: viewModel.comments?.length ?? 0,
    );
  }
}
