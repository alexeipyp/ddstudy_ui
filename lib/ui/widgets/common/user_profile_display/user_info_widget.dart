import 'package:auto_size_text/auto_size_text.dart';
import 'package:ddstudy_ui/domain/enums/subscribe_state.dart';
import 'package:ddstudy_ui/ui/widgets/common/post_display/post_display_view_models/iterable_post_display_view_model.dart';
import 'package:ddstudy_ui/ui/widgets/common/user_profile_display/subscribe_button_state.dart';
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
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                children: [
                  _FormattedText(
                      textString:
                          "birth at: ${viewModel.user == null ? "-" : dtf.format(viewModel.user!.birthDate)}"),
                  const Spacer(),
                  T != CurrentUserProfileViewModel
                      ? _SubscribeButton<T>()
                      : const SizedBox.shrink(),
                ],
              ),
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
            ],
          ),
        ),
      ],
    );
  }
}

class _SubscribeButton<T extends UserPostDisplayViewModel>
    extends StatelessWidget {
  const _SubscribeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T viewModel = context.watch<T>();
    var subState = viewModel.subscribeStatus != null
        ? SubscribeStates.getSubscribeState(viewModel.subscribeStatus!)
        : null;
    return subState != null
        ? Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              style: SubscribeButtonState.subscribeButtonStyle[subState]!,
              onPressed: subState == SubscribeStateEnum.notSentRequest
                  ? viewModel.onFollowUserButtonClicked
                  : subState == SubscribeStateEnum.subscribed
                      ? viewModel.onUndoFollowUserButtonClicked
                      : null,
              child: Text(SubscribeButtonState.subscribeButtonText[subState]!),
            ),
          )
        : const SizedBox.shrink();
  }
}

class _CurrentUserAvatarDisplay<T extends CurrentUserProfileViewModel>
    extends StatelessWidget {
  final Image? avatar;
  const _CurrentUserAvatarDisplay({
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
  final Image? image;
  const _AvatarDisplay({
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
