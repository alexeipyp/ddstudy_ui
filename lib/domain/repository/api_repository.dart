import 'package:ddstudy_ui/domain/models/user/user_profile.dart';

import '../models/token/token_response.dart';
import '../models/user/user_activity.dart';

abstract class ApiRepository {
  Future<TokenResponse?> getToken(
      {required String login, required String password});

  Future<TokenResponse?> refreshToken(String refreshToken);
  Future<UserProfile?> getUser();
  Future<UserActivity?> getUserActivity();
}
