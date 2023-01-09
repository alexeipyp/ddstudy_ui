import 'package:ddstudy_ui/ui/widgets/common/user_profile_display/user_profile_preview.dart';
import 'package:ddstudy_ui/ui/widgets/tab_profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentUserProfileWidget extends StatelessWidget {
  const CurrentUserProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const UserProfilePreview<CurrentUserProfileViewModel>();
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          CurrentUserProfileViewModel(context: context),
      child: const CurrentUserProfileWidget(),
    );
  }
}
