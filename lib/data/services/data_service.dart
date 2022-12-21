import 'package:ddstudy_ui/domain/db_model.dart';
import 'package:ddstudy_ui/domain/models/post/post_model.dart';
import 'package:ddstudy_ui/domain/models/post/post_stats.dart';

import '../../domain/models/post/post.dart';
import '../../domain/models/post/post_attach.dart';
import '../../domain/models/user/user.dart';
import 'database.dart';

class DataService {
  Future cuUser(User user) async {
    await DB.instance.createUpdate(user);
  }

  Future rangeUpdateEntities<T extends DBModel>(Iterable<T> elems) async {
    await DB.instance.createUpdateRange(elems);
  }

  Future eraseData() async {
    await DB.instance.cleanTable<PostStats>();
    await DB.instance.cleanTable<PostAttach>();
    await DB.instance.cleanTable<Post>();
    await DB.instance.cleanTable<User>();
  }

  Future<List<PostModel>> getFeed() async {
    var res = <PostModel>[];
    var posts = await DB.instance.getAll<Post>(orderBy: "uploadDate DESC");
    for (var post in posts) {
      var author = await DB.instance.get<User>(post.authorId);
      var attaches =
          (await DB.instance.getAll<PostAttach>(whereMap: {"postId": post.id}))
              .toList();
      var stats = await DB.instance.get<PostStats>(post.id);
      if (author != null && stats != null) {
        res.add(PostModel(
          id: post.id,
          author: author,
          attaches: attaches,
          annotation: post.annotation,
          uploadDate: post.uploadDate,
          stats: stats,
        ));
      }
    }
    return res;
  }
}
