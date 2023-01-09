import 'package:ddstudy_ui/ui/widgets/common/post_display/none_posts_widget.dart';
import 'package:ddstudy_ui/ui/widgets/common/post_display/posts_list_view/post_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_view_model.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<HomeViewModel>();

    return RefreshIndicator(
      onRefresh: viewModel.refreshPosts,
      child: viewModel.posts == null
          ? const Center(child: CircularProgressIndicator())
          : viewModel.posts!.isEmpty
              ? const NonePostWidget(
                  textMessage:
                      "Здесь отобразятся публикации тех, на кого подпишитесь",
                )
              : const PostListView<HomeViewModel>(),
    );
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeViewModel(context),
      child: const HomeWidget(),
    );
  }
}
