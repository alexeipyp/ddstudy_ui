import 'dart:io';

import 'package:ddstudy_ui/ui/widgets/common/cam_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/user/user.dart';
import '../../../domain/models/user/user_activity.dart';
import '../../../internal/config/shared_prefs.dart';
import '../../../internal/dependencies/repository_module.dart';
import '../roots/app.dart';

class ProfileViewModel extends ChangeNotifier {
  BuildContext context;
  final _api = RepositoryModule.apiRepository();
  ProfileViewModel({required this.context}) {
    asyncInit();
    var appmodel = context.read<AppViewModel>();
    appmodel.addListener(() {
      avatar = appmodel.avatar;
    });
  }

  User? _user;
  User? get user => _user;
  set user(User? val) {
    _user = val;
    notifyListeners();
  }

  String avatarCacheKey = "avatar";
  Image? _avatar;
  Image? get avatar => _avatar;
  set avatar(Image? val) {
    _avatar = val;
    notifyListeners();
  }

  UserActivity? _userActivity;
  UserActivity? get userActivity => _userActivity;
  set userActivity(UserActivity? val) {
    _userActivity = val;
    notifyListeners();
  }

  void asyncInit() async {
    user = await SharedPrefs.getStoredUser();
    userActivity = await _api.getUserActivity();
  }

  Future changePhoto() async {
    String? imagePath;
    var appmodel = context.read<AppViewModel>();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((newContext) => Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: CamWidget(
                  onFile: (file) {
                    imagePath = file.path;
                    Navigator.of(newContext).pop();
                  },
                ),
              ),
            )),
      ),
    );
    if (imagePath != null) {
      var temp = await _api.uploadTemp(files: [File(imagePath!)]);
      if (temp.isNotEmpty) {
        await _api.addAvatarToUser(temp.first);
        appmodel.refreshAvatar();
      }
    }
  }
}
