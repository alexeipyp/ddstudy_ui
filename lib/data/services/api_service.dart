import 'package:ddstudy_ui/domain/models/user/user_activity.dart';

import '../../domain/repository/api_repository.dart';
import '../../internal/dependencies/repository_module.dart';

class ApiService {
  final ApiRepository _api = RepositoryModule.apiRepository();

  Future<UserActivity?> getUserActivity() async {
    var userActivity = await _api.getUserActivity();
    return userActivity;
  }
}
