import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../post_display_view_models/iterable_post_display_view_model.dart';
import '../post_single_view/post_preview.dart';

class PostListView<T extends IterablePostDisplayViewModel>
    extends StatelessWidget {
  const PostListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel;
    viewModel = context.watch<T>();
    return ListView.separated(
      controller: viewModel.lvc,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: ((listContext, listIndex) {
        Widget res;
        if (viewModel.posts != null) {
          res = PostPreview<T>(
            postId: viewModel.posts![listIndex].id,
          );
        } else {
          res = const SizedBox.shrink();
        }
        return res;
      }),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: viewModel.posts?.length ?? 0,
    );
  }
}
