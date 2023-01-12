import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../post_display_view_models/post_display_view_model.dart';
import 'page_indicator.dart';
import 'post_annotation_preview.dart';
import 'post_attach_page_view.dart';
import 'post_author_preview.dart';
import 'post_stats_preview.dart';

class PostPreview<T extends PostDisplayViewModel> extends StatelessWidget {
  final String postId;
  const PostPreview({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel;
    viewModel = context.watch<T>();
    var screenSize = MediaQuery.of(context).size;
    var post = viewModel.getPostById(postId);
    return Container(
      color: Color.fromARGB(255, 70, 130, 250),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                PostAuthorPreview<T>(
                  authorId: post.author.id,
                  authorName: post.author.name,
                  avatarLink: post.author.avatarLink,
                ),
              ],
            ),
          ),
          PostAttachPageView<T>(
            post: post,
            dimension: screenSize.width,
          ),
          Row(
            children: [
              PostStatsPreview<T>(postId: postId),
              const Spacer(),
              PageIndicator(
                  count: post.attaches.length,
                  current: viewModel.getPageIndex(post.id)),
            ],
          ),
          post.annotation != null
              ? PostAnnotationPreview(
                  authorName: post.author.name,
                  annotation: post.annotation!,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
