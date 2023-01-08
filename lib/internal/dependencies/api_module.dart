// ignore_for_file: deprecated_member_use

import 'package:ddstudy_ui/data/clients/auth_client.dart';
import 'package:ddstudy_ui/data/services/auth_service.dart';
import 'package:ddstudy_ui/domain/models/token/refresh_token_request.dart';
import 'package:ddstudy_ui/internal/config/app_config.dart';
import 'package:ddstudy_ui/internal/config/token_storage.dart';
import 'package:ddstudy_ui/ui/navigation/global_navigator.dart';
import 'package:dio/dio.dart';

import '../../data/clients/api_client.dart';

class ApiModule {
  static AuthClient? _authClient;
  static ApiClient? _apiClient;
  static Dio? _mediaFetcher;

  static AuthClient auth() {
    _authClient ??= AuthClient(
      Dio(),
      baseUrl: baseUrl,
    );
    return _authClient!;
  }

  static ApiClient api() {
    _apiClient ??= ApiClient(
      _addInterceptors(Dio()),
      baseUrl: baseUrl,
    );
    return _apiClient!;
  }

  static Dio media() {
    _mediaFetcher ??= _addInterceptors(Dio());
    return _mediaFetcher!;
  }

  static Dio _addInterceptors(Dio dio) {
    dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getAccessToken();
        options.headers.addAll({"Authorization": "Bearer $token"});
        return handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          RequestOptions options = e.response!.requestOptions;

          var rt = await TokenStorage.getRefreshToken();
          try {
            if (rt != null) {
              var token = await auth()
                  .refreshToken(RefreshTokenRequest(refreshToken: rt));
              await TokenStorage.setStoredToken(token);
              options.headers["Authorization"] = "Bearer ${token!.accessToken}";
            }
          } catch (e) {
            var service = AuthService();
            await service.logout();
            GlobalNavigator.toLoader();

            return handler.resolve(Response(
              requestOptions: options,
              statusCode: 400,
            ));
          }
          return handler.resolve(await dio.fetch(options));
        } else {
          return handler.next(e);
        }
      },
    ));

    return dio;
  }
}
