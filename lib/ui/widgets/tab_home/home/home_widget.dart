import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../internal/config/app_config.dart';
import 'home_view_model.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<HomeViewModel>();
    var screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        child: viewModel.posts == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                controller: viewModel.lvc,
                itemBuilder: ((listContext, listIndex) {
                  Widget res;
                  var posts = viewModel.posts;
                  if (posts != null) {
                    var post = posts[listIndex];
                    res = Container(
                      padding: const EdgeInsets.all(10),
                      height: screenSize.width,
                      color: Colors.blueGrey,
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              onPageChanged: (value) =>
                                  viewModel.onPageChanged(listIndex, value),
                              itemCount: post.attaches.length,
                              itemBuilder: (pageContext, pageIndex) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: viewModel.headers != null
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "$baseUrl${post.attaches[pageIndex].attachLink}",
                                            headers: viewModel.headers,
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          PageIndicator(
                              count: post.attaches.length,
                              current: viewModel.pager[listIndex]),
                          Text(post.annotation ?? ""),
                        ],
                      ),
                    );
                  } else {
                    res = const SizedBox.shrink();
                  }
                  return res;
                }),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: viewModel.posts?.length ?? 0,
              ),
      ),
    );
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeViewModel(context: context),
      child: const HomeWidget(),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int count;
  final int? current;
  final double width;
  const PageIndicator({
    Key? key,
    required this.count,
    required this.current,
    this.width = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    for (var i = 0; i < count; i++) {
      widgets.add(Icon(
        i == (current ?? 0) ? Icons.circle : Icons.circle_outlined,
        size: width,
        color: Theme.of(context).primaryColor,
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
}
