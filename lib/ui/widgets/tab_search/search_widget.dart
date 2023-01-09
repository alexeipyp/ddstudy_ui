import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/post_display/none_posts_widget.dart';
import '../common/post_display/posts_grid_view/post_grid_view.dart';
import 'search_view_model.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<SearchViewModel>();

    return RefreshIndicator(
      onRefresh: viewModel.refreshPosts,
      child: Column(children: [
        viewModel.errText != null
            ? Text(viewModel.errText!)
            : const SizedBox.shrink(),
        Expanded(
          child: viewModel.posts == null
              ? const Center(child: CircularProgressIndicator())
              : viewModel.posts!.isEmpty
                  ? const NonePostWidget(
                      textMessage: "Нет новых публикаций :(",
                    )
                  : const PostGridView<SearchViewModel>(),
        ),
      ]),
    );
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SearchViewModel(context),
      child: const SearchWidget(),
    );
  }
}
