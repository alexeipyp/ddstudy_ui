import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../post_display_view_models/post_display_view_model.dart';

class PostStatsPreview<T extends PostDisplayViewModel> extends StatelessWidget {
  final String postId;
  const PostStatsPreview({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel;
    viewModel = context.watch<T>();
    var post = viewModel.getPostById(postId);
    return Row(
      children: [
        IconButton(
          onPressed: () => viewModel.onLikeButtonPressed(postId),
          icon: Icon(
            Icons.favorite,
            color: post.stats.whenLiked != null
                ? Colors.red
                : Theme.of(context).primaryColor,
          ),
        ),
        Text("${post.stats.likesAmount}"),
        IconButton(
          onPressed: () => viewModel.onCommentsButtonPressed(postId),
          icon: Icon(
            Icons.chat_bubble,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text("${post.stats.commentsAmount}"),
      ],
    );
  }
}
