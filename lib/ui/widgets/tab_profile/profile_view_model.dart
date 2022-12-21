import 'dart:io';

import 'package:ddstudy_ui/ui/widgets/common/cam_widget.dart';
import 'package:flutter/material.dart';

import '../../../data/services/api_service.dart';
import '../../../data/services/auth_service.dart';
import '../../../domain/models/user/user.dart';
import '../../../domain/models/user/user_activity.dart';
import '../../../internal/config/shared_prefs.dart';
import '../../../internal/config/token_storage.dart';
import '../../../internal/dependencies/repository_module.dart';

class ProfileViewModel extends ChangeNotifier {
  BuildContext context;
  final _api = RepositoryModule.apiRepository();
  ProfileViewModel({required this.context}) {
    asyncInit();
  }

  User? _user;
  User? get user => _user;
  set user(User? val) {
    _user = val;
    notifyListeners();
  }

  UserActivity? _userActivity;
  UserActivity? get userActivity => _userActivity;
  set userActivity(UserActivity? val) {
    _userActivity = val;
    notifyListeners();
  }

  Map<String, String>? headers;

  void asyncInit() async {
    user = await SharedPrefs.getStoredUser();
    userActivity = await _api.getUserActivity();
    var token = await TokenStorage.getAccessToken();
    headers = {"Authorization": "Bearer $token"};
  }

  String? _imagePath;
  String? get imagePath => _imagePath;
  set imagePath(String? val) {
    _imagePath = val;
    notifyListeners();
  }

  Future changePhoto() async {
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
      }
    }
  }
}
