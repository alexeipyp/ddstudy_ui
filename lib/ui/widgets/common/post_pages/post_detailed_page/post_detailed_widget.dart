import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'numeric_page_indicator.dart';
import 'post_attach_interactive.dart';
import 'post_detailed_view_model.dart';

class PostDetailedWidget extends StatelessWidget {
  const PostDetailedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<PostDetailedViewModel>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        PageView.builder(
          controller: viewModel.pageController,
          physics: viewModel.isScrollLock
              ? const NeverScrollableScrollPhysics()
              : const ClampingScrollPhysics(),
          onPageChanged: (value) => viewModel.onPageChanged(value),
          itemCount: viewModel.postAttachesLinks.length,
          itemBuilder: (pageContext, pageIndex) => PostAttachInteractive(
            attachLink: viewModel.postAttachesLinks[pageIndex],
            pageIndex: pageIndex,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NumericPageIndicator(
              count: viewModel.postAttachesLinks.length,
              current: viewModel.pageIndex,
            ),
          ],
        ),
      ]),
    );
  }

  static create(Object? arg) {
    List<String>? postAttachesLinks;
    if (arg != null && arg is List<String>) postAttachesLinks = arg;
    return ChangeNotifierProvider(
      create: (BuildContext context) => PostDetailedViewModel(
        context: context,
        postAttachesLinks: postAttachesLinks!,
      ),
      child: const PostDetailedWidget(),
    );
  }
}
