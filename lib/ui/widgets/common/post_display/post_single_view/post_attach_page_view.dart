import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/post/post_model.dart';
import '../post_display_view_models/post_display_view_model.dart';
import 'post_attach_preview.dart';

class PostAttachPageView<T extends PostDisplayViewModel>
    extends StatelessWidget {
  final PostModel post;
  final double dimension;
  const PostAttachPageView({
    Key? key,
    required this.post,
    required this.dimension,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel;
    viewModel = context.watch<T>();
    return GestureDetector(
      onTap: () => viewModel.openPostInDetailedPage(post.id),
      child: SizedBox.square(
        dimension: dimension,
        child: PageView.builder(
          onPageChanged: (value) => viewModel.onPageChanged(post.id, value),
          itemCount: post.attaches.length,
          itemBuilder: (pageContext, pageIndex) => PostAttachPreview(
            attachLink: post.attaches[pageIndex].attachLink,
          ),
        ),
      ),
    );
  }
}
