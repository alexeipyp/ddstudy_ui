import 'package:ddstudy_ui/data/services/data_service.dart';
import 'package:ddstudy_ui/internal/dependencies/repository_module.dart';

import '../../domain/models/post/post.dart';
import '../../domain/repository/api_repository.dart';

class SyncService {
  final ApiRepository _api = RepositoryModule.apiRepository();
  final DataService _dataService = DataService();

  Future syncPosts() async {
    var postModels = await _api.getFeed(0, 100);
    var authors = postModels.map((e) => e.author).toSet();
    var postAttaches = postModels
        .expand((x) => x.attaches.map((e) => e.copyWith(postId: x.id)))
        .toList();
    var postStats = postModels.map((e) => e.stats.copyWith(id: e.id)).toList();
    var posts = postModels
        .map((e) => Post.fromJson(e.toJson()).copyWith(authorId: e.author.id))
        .toList();

    await _dataService.rangeUpdateEntities(authors);
    await _dataService.rangeUpdateEntities(posts);
    await _dataService.rangeUpdateEntities(postAttaches);
    await _dataService.rangeUpdateEntities(postStats);
  }
}
