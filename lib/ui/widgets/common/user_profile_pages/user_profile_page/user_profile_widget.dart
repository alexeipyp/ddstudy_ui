import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../user_profile_display/user_profile_preview.dart';
import 'user_profile_view_model.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<UserProfileViewModel>();
    return viewModel.user != null && viewModel.userActivity != null
        ? const UserProfilePreview<UserProfileViewModel>()
        : const Center(child: CircularProgressIndicator());
  }

  static create(Object? arg) {
    String? userId;
    if (arg != null && arg is String) userId = arg;
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserProfileViewModel(
        context: context,
        authorId: userId!,
      ),
      child: const UserProfileWidget(),
    );
  }
}
