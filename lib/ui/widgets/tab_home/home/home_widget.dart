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
      onRefresh: viewModel.refreshFeed,
      child: viewModel.posts == null
          ? viewModel.isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : const NoneSubPostsWidget()
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

class NoneSubPostsWidget extends StatelessWidget {
  const NoneSubPostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(children: const [
            Text("Нет постов :("),
          ]),
        ),
      ],
    );
  }
}
