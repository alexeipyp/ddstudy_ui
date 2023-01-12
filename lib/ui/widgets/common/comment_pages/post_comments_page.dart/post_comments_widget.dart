import 'package:ddstudy_ui/domain/enums/content_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../comment_display/comment_list_view.dart';
import '../../none_content_widget.dart';
import 'post_comments_view_model.dart';

class PostCommentsWidget extends StatelessWidget {
  const PostCommentsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<PostCommentsViewModel>();

    return viewModel.comments == null || viewModel.isCommentsLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text("Комментарии"),
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: viewModel.comments!.isNotEmpty
                        ? const CommentListView<PostCommentsViewModel>()
                        : const NoneContentWidget(
                            contentType: ContentTypeEnum.comments,
                          ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: CreateCommentWidget(),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndTop,
            floatingActionButton: viewModel.lvc.hasClients
                ? viewModel.lvc.offset == viewModel.lvc.position.maxScrollExtent
                    ? const SizedBox.shrink()
                    : FloatingActionButton.small(
                        onPressed: viewModel.scrollToEnd,
                        child: const Icon(Icons.arrow_downward),
                      )
                : const SizedBox.shrink(),
          );
  }

  static create(Object? arg) {
    String? postId;
    if (arg != null && arg is String) postId = arg;
    return ChangeNotifierProvider(
      create: (BuildContext context) => PostCommentsViewModel(context, postId!),
      child: const PostCommentsWidget(),
    );
  }
}

class CreateCommentWidget extends StatelessWidget {
  const CreateCommentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<PostCommentsViewModel>();
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: viewModel.commentTextTec,
            decoration: const InputDecoration(hintText: "Type here"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            onPressed: viewModel.sendComment,
            child: const Text("Send"),
          ),
        ),
      ],
    );
  }
}
