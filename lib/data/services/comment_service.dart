import '../../domain/repository/api_repository.dart';
import '../../internal/dependencies/repository_module.dart';

class CommentService {
  final ApiRepository _api = RepositoryModule.apiRepository();

  Future commentPost(String postId, String text) =>
      _api.commentPost(postId, text);
}
