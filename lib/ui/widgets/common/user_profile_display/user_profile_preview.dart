import 'package:ddstudy_ui/domain/enums/content_type.dart';
import 'package:ddstudy_ui/ui/widgets/common/post_display/post_display_view_models/iterable_post_display_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../none_content_widget.dart';
import '../post_display/posts_grid_view/post_grid_view.dart';
import 'user_info_widget.dart';

class UserProfilePreview<T extends UserPostDisplayViewModel>
    extends StatelessWidget {
  const UserProfilePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel = context.watch<T>();
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(children: [
        SizedBox(
          height: screenSize.height * 0.18,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            child: UserInfoWidget<T>(),
          ),
        ),
        Expanded(
          child: viewModel.posts == null
              ? const Center(child: CircularProgressIndicator())
              : viewModel.posts!.isEmpty
                  ? const NoneContentWidget(
                      contentType: ContentTypeEnum.userPosts,
                    )
                  : PostGridView<T>(),
        ),
      ]),
    );
  }
}
