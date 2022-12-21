import 'package:flutter/material.dart';

import '../../../../data/services/auth_service.dart';
import '../../../../data/services/data_service.dart';
import '../../../../data/services/sync_service.dart';
import '../../../../domain/models/post/post_model.dart';
import '../../../../internal/config/token_storage.dart';
import '../../../navigation/global_navigator.dart';

class HomeViewModel extends ChangeNotifier {
  BuildContext context;
  final _dataService = DataService();
  final _authService = AuthService();
  final lvc = ScrollController();
  //final mediaService = MediaFetchService();
  HomeViewModel({required this.context}) {
    asyncInit();
  }

  Map<String, String>? headers;

  List<PostModel>? _posts;
  List<PostModel>? get posts => _posts;
  set posts(List<PostModel>? val) {
    _posts = val;
    notifyListeners();
  }

  Map<int, int> pager = <int, int>{};

  void onPageChanged(int listIndex, int pageIndex) {
    pager[listIndex] = pageIndex;
    notifyListeners();
  }

  void asyncInit() async {
    await SyncService().syncPosts();
    posts = await _dataService.getFeed();
    var token = await TokenStorage.getAccessToken();
    headers = {"Authorization": "Bearer $token"};
  }
}
