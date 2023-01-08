import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/post_display/posts_grid_view/post_grid_view.dart';
import 'favorites_view_model.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<FavoriteViewModel>();

    return RefreshIndicator(
      onRefresh: viewModel.refreshFeed,
      child: Column(children: [
        viewModel.errText != null
            ? Text(viewModel.errText!)
            : const SizedBox.shrink(),
        Expanded(
          child: viewModel.posts == null
              ? viewModel.isLoading == true
                  ? const Center(child: CircularProgressIndicator())
                  : const NoneFavoritePostsWidget()
              : const PostGridView<FavoriteViewModel>(),
        ),
      ]),
    );
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FavoriteViewModel(context),
      child: const FavoriteWidget(),
    );
  }
}

class NoneFavoritePostsWidget extends StatelessWidget {
  const NoneFavoritePostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(children: const [
            Text("Нет любимых постов :("),
          ]),
        ),
      ],
    );
  }
}
