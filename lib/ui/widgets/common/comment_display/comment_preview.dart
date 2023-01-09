import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/comment/comment_model.dart';
import '../../../../internal/config/app_config.dart';
import 'comment_display_view_models/comment_display_view_model.dart';

class CommentPreview<T extends CommentDisplayViewModel>
    extends StatelessWidget {
  final String commentId;
  const CommentPreview({
    Key? key,
    required this.commentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel = context.watch<T>();
    var comment = viewModel.getCommentById(commentId);
    return Container(
      margin: const EdgeInsets.all(5),
      child: comment.author.id == viewModel.currentUserId
          ? _CurrentUserCommentPreview<T>(comment: comment)
          : _NotCurrentUserCommentPreview<T>(comment: comment),
    );
  }
}

class _NotCurrentUserCommentPreview<T extends CommentDisplayViewModel>
    extends StatelessWidget {
  final CommentModel comment;
  final textAlign = CrossAxisAlignment.start;
  final alignment = MainAxisAlignment.start;
  const _NotCurrentUserCommentPreview({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _Avatar<T>(
        avatarLink: comment.author.avatarLink,
        authorId: comment.author.id,
      ),
      _CommentText<T>(
        authorName: comment.author.name,
        text: comment.text,
        authorId: comment.author.id,
        alignment: alignment,
        textAlignment: textAlign,
      ),
    ]);
  }
}

class _CurrentUserCommentPreview<T extends CommentDisplayViewModel>
    extends StatelessWidget {
  final CommentModel comment;
  final textAlign = CrossAxisAlignment.end;
  final alignment = MainAxisAlignment.end;
  const _CurrentUserCommentPreview({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _CommentText<T>(
        authorName: comment.author.name,
        text: comment.text,
        authorId: comment.author.id,
        alignment: alignment,
        textAlignment: textAlign,
      ),
      _Avatar<T>(
        avatarLink: comment.author.avatarLink,
        authorId: comment.author.id,
      ),
    ]);
  }
}

class _Avatar<T extends CommentDisplayViewModel> extends StatelessWidget {
  final String? avatarLink;
  final String authorId;
  const _Avatar({
    Key? key,
    this.avatarLink,
    required this.authorId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel = context.watch<T>();
    return Container(
      margin: const EdgeInsets.only(right: 5, left: 5),
      child: GestureDetector(
        onTap: () {
          viewModel.openAuthorProfilePage(authorId);
        },
        child: CircleAvatar(
            backgroundImage: avatarLink != null
                ? CachedNetworkImageProvider(
                    "$AppConfig.baseUrl$avatarLink",
                    cacheManager: DioCacheManager.instance,
                  )
                : null),
      ),
    );
  }
}

class _CommentText<T extends CommentDisplayViewModel> extends StatelessWidget {
  final String authorName;
  final String text;
  final String authorId;
  final MainAxisAlignment alignment;
  final CrossAxisAlignment textAlignment;
  const _CommentText({
    Key? key,
    required this.authorName,
    required this.text,
    required this.authorId,
    required this.alignment,
    required this.textAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel = context.watch<T>();
    return Expanded(
      flex: 8,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: alignment,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: textAlignment,
              children: [
                GestureDetector(
                  onTap: () {
                    viewModel.openAuthorProfilePage(authorId);
                  },
                  child: Text(
                    authorName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  text,
                ),
              ],
            ),
          ]),
    );
  }
}
