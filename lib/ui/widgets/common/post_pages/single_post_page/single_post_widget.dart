import 'package:ddstudy_ui/ui/widgets/common/post_display/post_single_view/post_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'single_post_view_model.dart';

class SinglePostWidget extends StatelessWidget {
  const SinglePostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<SinglePostViewModel>();
    return Scaffold(
      appBar: AppBar(),
      body: viewModel.post == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: PostPreview<SinglePostViewModel>(
              postId: viewModel.postId,
            )),
    );
  }

  static create(Object? arg) {
    String? postId;
    if (arg != null && arg is String) postId = arg;
    return ChangeNotifierProvider(
      create: (BuildContext context) => SinglePostViewModel(context, postId!),
      child: const SinglePostWidget(),
    );
  }
}
