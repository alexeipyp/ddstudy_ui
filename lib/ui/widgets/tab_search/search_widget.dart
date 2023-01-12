import 'package:ddstudy_ui/domain/enums/content_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/none_content_widget.dart';
import '../common/post_display/posts_grid_view/post_grid_view.dart';
import 'search_view_model.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<SearchViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Поиск"),
      ),
      body: RefreshIndicator(
        onRefresh: viewModel.refreshPosts,
        child: Column(children: [
          viewModel.errText != null
              ? Text(viewModel.errText!)
              : const SizedBox.shrink(),
          Expanded(
            child: viewModel.posts == null
                ? const Center(child: CircularProgressIndicator())
                : viewModel.posts!.isEmpty
                    ? const NoneContentWidget(
                        contentType: ContentTypeEnum.search,
                      )
                    : const PostGridView<SearchViewModel>(),
          ),
        ]),
      ),
    );
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SearchViewModel(context),
      child: const SearchWidget(),
    );
  }
}
