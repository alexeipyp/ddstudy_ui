import 'package:auto_size_text/auto_size_text.dart';
import 'package:ddstudy_ui/ui/widgets/tab_profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dtf = DateFormat("dd.MM.yyyy");
    var viewModel = context.watch<ProfileViewModel>();
    return SafeArea(
      child: Column(
        children: [
          // Avatar Image
          Flexible(
              flex: 8,
              child: GestureDetector(
                onTap: viewModel.changePhoto,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  constraints: const BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 6,
                    ),
                    shape: BoxShape.circle,
                    image: (viewModel.user != null && viewModel.avatar != null)
                        ? DecorationImage(
                            image: viewModel.avatar!.image,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
              )),
          // Full Name
          Flexible(
            flex: 2,
            child: _TextContainer(
              textString: viewModel.user == null ? "Hi" : viewModel.user!.name,
              styleFromAppTheme: Theme.of(context).textTheme.headline4,
            ),
          ),
          // Some User Data
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TextContainer(
                  textString:
                      "Email: ${viewModel.user == null ? "-" : viewModel.user!.email}",
                ),
                _TextContainer(
                  textString:
                      "Birth at: ${viewModel.user == null ? "-" : dtf.format(viewModel.user!.birthDate)}",
                ),
              ],
            ),
          ),
          // Some User Activity
          Flexible(
            flex: 2,
            child: _UserActivity(
              postsAmount: viewModel.userActivity == null
                  ? null
                  : viewModel.userActivity!.postsAmount,
              followersAmount: viewModel.userActivity == null
                  ? null
                  : viewModel.userActivity!.followersAmount,
              followingAmount: viewModel.userActivity == null
                  ? null
                  : viewModel.userActivity!.followingAmount,
              styleFromAppTheme: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProfileViewModel(context: context),
      child: const ProfileWidget(),
    );
  }
}

class _TextContainer extends StatelessWidget {
  const _TextContainer({
    required this.textString,
    this.styleFromAppTheme,
  });

  final String textString;
  final TextStyle? styleFromAppTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: AutoSizeText(
          textString,
          maxLines: 1,
          style: styleFromAppTheme?.merge(const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
    );
  }
}

class _UserActivity extends StatelessWidget {
  const _UserActivity({
    this.postsAmount,
    this.followersAmount,
    this.followingAmount,
    this.styleFromAppTheme,
  });

  final int? postsAmount;
  final int? followersAmount;
  final int? followingAmount;
  final TextStyle? styleFromAppTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Row(
        children: [
          const Spacer(flex: 2),
          Column(
            children: [
              AutoSizeText(
                "Posts",
                style: styleFromAppTheme,
              ),
              AutoSizeText(
                "${postsAmount ?? "-"}",
                style: styleFromAppTheme,
              ),
            ],
          ),
          const Spacer(flex: 2),
          Column(
            children: [
              AutoSizeText(
                "Followers",
                style: styleFromAppTheme,
              ),
              AutoSizeText(
                "${followersAmount ?? "-"}",
                style: styleFromAppTheme,
              ),
            ],
          ),
          const Spacer(flex: 2),
          Column(
            children: [
              AutoSizeText(
                "Following",
                style: styleFromAppTheme,
              ),
              AutoSizeText(
                "${followingAmount ?? "-"}",
                style: styleFromAppTheme,
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
