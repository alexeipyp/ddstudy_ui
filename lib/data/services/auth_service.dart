import 'dart:io';

import 'package:ddstudy_ui/data/services/data_service.dart';
import 'package:ddstudy_ui/domain/repository/api_repository.dart';
import 'package:ddstudy_ui/internal/config/shared_prefs.dart';
import 'package:ddstudy_ui/internal/config/token_storage.dart';
import 'package:ddstudy_ui/internal/dependencies/repository_module.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager_dio/flutter_cache_manager_dio.dart';

import '../../utils/exceptions.dart';

class AuthService {
  final ApiRepository _api = RepositoryModule.apiRepository();
  final DataService _dataService = DataService();

  Future auth(String? login, String? password) async {
    if (login != null && password != null) {
      try {
        var token = await _api.getToken(login: login, password: password);
        if (token != null) {
          await TokenStorage.setStoredToken(token);
          var user = await _api.getUser();
          var previousUser = await SharedPrefs.getStoredUser();
          if (user != null) {
            if (!(user == previousUser)) {
              await _dataService.eraseData();
              DioCacheManager.instance.emptyCache();
            }
            SharedPrefs.setStoredUser(user);
          }
        }
      } on DioError catch (e) {
        if (e.error is SocketException) {
          throw NoNetworkException();
        } else {
          if (e.response?.statusCode == 401) {
            throw WrongCredentialsException();
          }
          if (e.response?.statusCode == 500) {
            throw ServerException();
          }
        }
      }
    }
  }

  Future register(
    String? name,
    String? email,
    String? password,
    String? retryPassword,
    DateTime? birthDate,
  ) async {
    if (name != null &&
        email != null &&
        password != null &&
        retryPassword != null &&
        birthDate != null) {
      try {
        await _api.registerUser(
          name: name,
          email: email,
          password: password,
          retryPassword: retryPassword,
          birthDate: birthDate,
        );
      } on DioError catch (e) {
        if (e.error is SocketException) {
          throw NoNetworkException();
        } else {
          if (e.response?.statusCode == 500) {
            throw ServerException();
          }
          if (e.response?.statusCode == 403) {
            throw EmailAlreadyBusyException();
          }
        }
      }
    }
  }

  Future<bool> checkAuth() async {
    var res = false;

    if (await TokenStorage.getAccessToken() != null) {
      var user = await _api.getUser();
      if (user != null) {
        await SharedPrefs.setStoredUser(user);
        await _dataService.cuUser(user);
      }

      res = true;
    }
    return res;
  }

  Future logout() async {
    await TokenStorage.setStoredToken(null);
  }
}
