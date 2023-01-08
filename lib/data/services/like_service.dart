import 'dart:io';

import 'package:dio/dio.dart';

import '../../domain/repository/api_repository.dart';
import '../../internal/dependencies/repository_module.dart';
import '../../utils/exceptions.dart';
import 'data_service.dart';

class LikeService {
  final ApiRepository _api = RepositoryModule.apiRepository();
  final DataService _dataService = DataService();

  Future likePost(String postId) async {
    try {
      var refreshedPostStats = await _api.likePost(postId);
      if (refreshedPostStats != null) {
        refreshedPostStats = refreshedPostStats.copyWith(id: postId);
        await _dataService.rangeUpdateEntity(refreshedPostStats);
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw NoNetworkException();
      } else {
        if (e.response?.statusCode == 500) {
          throw ServerException();
        }
      }
    }
  }
}
