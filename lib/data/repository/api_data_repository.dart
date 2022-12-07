import 'package:ddstudy_ui/data/clients/auth_client.dart';
import 'package:ddstudy_ui/domain/models/token/refresh_token_request.dart';
import 'package:ddstudy_ui/domain/models/token/token_request.dart';
import 'package:ddstudy_ui/domain/models/token/token_response.dart';
import 'package:ddstudy_ui/domain/models/user/user_activity.dart';
import 'package:ddstudy_ui/domain/models/user/user_profile.dart';
import 'package:ddstudy_ui/domain/repository/api_repository.dart';

import '../clients/api_client.dart';

class ApiDataRepository extends ApiRepository {
  final AuthClient _auth;
  final ApiClient _api;
  ApiDataRepository(this._auth, this._api);

  @override
  Future<TokenResponse?> getToken({
    required String login,
    required String password,
  }) async {
    return await _auth.getToken(TokenRequest(login: login, password: password));
  }

  @override
  Future<UserProfile?> getUser() => _api.getCurrentUserProfile();

  @override
  Future<UserActivity?> getUserActivity() => _api.getCurrentUserActivity();

  @override
  Future<TokenResponse?> refreshToken(String refreshToken) async =>
      await _auth.refreshToken(RefreshTokenRequest(
        refreshToken: refreshToken,
      ));
}
