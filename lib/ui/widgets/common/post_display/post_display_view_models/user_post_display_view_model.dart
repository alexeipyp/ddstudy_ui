part of 'iterable_post_display_view_model.dart';

class UserPostDisplayViewModel extends GridPostDisplayViewModel {
  UserPostDisplayViewModel({
    required BuildContext context,
    required int postsUploadAmountPerSync,
  }) : super(
          context: context,
          feedType: FeedTypeEnum.userPosts,
          postsUploadAmountPerSync: postsUploadAmountPerSync,
        );

  User? _user;
  User? get user => _user;
  set user(User? val) {
    _user = val;
    notifyListeners();
  }

  String avatarCacheKey = "avatar";
  Image? _avatar;
  Image? get avatar => _avatar;
  set avatar(Image? val) {
    _avatar = val;
    notifyListeners();
  }

  UserActivity? _userActivity;
  UserActivity? get userActivity => _userActivity;
  set userActivity(UserActivity? val) {
    _userActivity = val;
    notifyListeners();
  }

  @override
  Future syncPosts({DateTime? upToDate}) async {
    if (_user != null) {
      await _syncService.syncPosts(feedType, postsUploadAmountPerSync,
          upToDate: upToDate, userId: _user!.id);
    }
  }

  @override
  Future<List<PostModel>> loadPostsFromDB({DateTime? upToDate}) async {
    List<PostModel> res = <PostModel>[];
    if (_user != null) {
      res = await _dataService.getFeed(feedType, postsUploadAmountPerSync,
          upToDate: upToDate, userId: _user!.id);
    }
    return res;
  }
}
