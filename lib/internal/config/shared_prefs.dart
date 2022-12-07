import 'dart:convert';

import 'package:ddstudy_ui/domain/models/user/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _userKey = "_kUser";

  static Future<UserProfile?> getStoredUser() async {
    var sp = await SharedPreferences.getInstance();
    var json = sp.getString(_userKey);
    return (json == "" || json == null)
        ? null
        : UserProfile.fromJson(jsonDecode(json));
  }

  static Future setStoredUser(UserProfile? user) async {
    var sp = await SharedPreferences.getInstance();
    if (user == null) {
      sp.remove(_userKey);
    } else {
      await sp.setString(
        _userKey,
        jsonEncode(user.toJson()),
      );
    }
  }
}
