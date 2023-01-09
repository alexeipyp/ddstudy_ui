import 'package:auto_size_text/auto_size_text.dart';
import 'package:ddstudy_ui/ui/widgets/common/post_display/post_display_view_models/iterable_post_display_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserInfoWidget<T extends UserPostDisplayViewModel>
    extends StatelessWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dtf = DateFormat("dd.MM.yyyy");
    T viewModel;
    viewModel = context.watch<T>();
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.all(10),
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
              shape: BoxShape.circle,
              image: (viewModel.avatar != null)
                  ? DecorationImage(
                      image: viewModel.avatar!.image,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: _FormattedText(
                        textString:
                            "${viewModel.userActivity == null ? "-" : viewModel.userActivity!.postsAmount}\nPosts"),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: _FormattedText(
                        textString:
                            "${viewModel.userActivity == null ? "-" : viewModel.userActivity!.followersAmount}\nFollowers"),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: _FormattedText(
                        textString:
                            "${viewModel.userActivity == null ? "-" : viewModel.userActivity!.followingAmount}\nFollowing"),
                    onPressed: () {},
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FormattedText(
                      textString:
                          "email: ${viewModel.user == null ? "-" : viewModel.user!.email}"),
                  _FormattedText(
                      textString:
                          "birth at: ${viewModel.user == null ? "-" : dtf.format(viewModel.user!.birthDate)}"),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class _FormattedText extends StatelessWidget {
  const _FormattedText({
    Key? key,
    required this.textString,
  }) : super(key: key);

  final String textString;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      textString,
      minFontSize: 10,
      maxLines: 2,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
