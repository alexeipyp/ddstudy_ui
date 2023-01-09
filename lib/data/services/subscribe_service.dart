import 'package:ddstudy_ui/internal/dependencies/repository_module.dart';

import 'data_service.dart';

class SubscribeService {
  final _api = RepositoryModule.apiRepository();
  final DataService _dataService = DataService();

  Future followUser(String authorId) async {
    var subStatus = await _api.followUser(authorId);
    if (subStatus != null) {
      subStatus = subStatus.copyWith(id: authorId);
      await _dataService.updateEntity(subStatus);
    }
  }

  Future undoFollowUser(String authorId) async {
    var subStatus = await _api.undoFollowUser(authorId);
    if (subStatus != null) {
      subStatus = subStatus.copyWith(id: authorId);
      await _dataService.updateEntity(subStatus);
    }
  }
}
