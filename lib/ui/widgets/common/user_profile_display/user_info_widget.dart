import 'package:auto_size_text/auto_size_text.dart';
import 'package:ddstudy_ui/ui/widgets/common/post_display/post_display_view_models/iterable_post_display_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../tab_profile/profile_view_model.dart';

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
          child: T == CurrentUserProfileViewModel
              ? _CurrentUserAvatarDisplay<CurrentUserProfileViewModel>(
                  avatar: viewModel.avatar,
                )
              : _AvatarDisplay(
                  image: viewModel.avatar,
                ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
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
              const Spacer(),
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
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class _CurrentUserAvatarDisplay<T extends CurrentUserProfileViewModel>
    extends StatelessWidget {
  Image? avatar;
  _CurrentUserAvatarDisplay({
    super.key,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    T viewModel = context.watch<T>();
    return GestureDetector(
      onTap: viewModel.changePhoto,
      child: _AvatarDisplay(image: avatar),
    );
  }
}

class _AvatarDisplay extends StatelessWidget {
  Image? image;
  _AvatarDisplay({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 3,
        ),
        shape: BoxShape.circle,
        image: (image != null)
            ? DecorationImage(
                image: image!.image,
                fit: BoxFit.cover,
              )
            : null,
      ),
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
