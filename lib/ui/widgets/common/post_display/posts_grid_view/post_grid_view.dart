import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../post_display_view_models/iterable_post_display_view_model.dart';
import 'grid_post_preview.dart';

class PostGridView<T extends GridPostDisplayViewModel> extends StatelessWidget {
  const PostGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel;
    viewModel = context.watch<T>();
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      controller: viewModel.lvc,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: ((listContext, listIndex) {
        Widget res;
        if (viewModel.posts != null) {
          var postId = viewModel.posts![listIndex].id;
          res = GestureDetector(
            onTap: () => viewModel.openPostInSinglePage(postId),
            child: GridPostPreview<T>(postId: postId),
          );
        } else {
          res = const SizedBox.shrink();
        }
        return res;
      }),
      itemCount: viewModel.posts?.length ?? 0,
    );
  }
}
