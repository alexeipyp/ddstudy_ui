import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../data/services/data_service.dart';
import '../../../../../data/services/like_service.dart';
import '../../../../../data/services/sync_service.dart';
import '../../../../../domain/models/comment/comment_model.dart';
import '../../../../../utils/exceptions.dart';
import 'comment_display_view_model.dart';

class IterableCommentDisplayViewModel extends CommentDisplayViewModel {
  final int commentsUploadAmountPerSync;
  final Duration refreshInterval;
  final _dataService = DataService();
  final _syncService = SyncService();
  final _likeService = LikeService();
  final lvc = ScrollController();
  IterableCommentDisplayViewModel({
    required BuildContext context,
    required this.commentsUploadAmountPerSync,
    required String postId,
    required this.refreshInterval,
  }) : super(context: context, postId: postId) {
    initializeScrollController();
    asyncInit();
  }

  List<CommentModel>? _comments;
  List<CommentModel>? get comments => _comments;
  set comments(List<CommentModel>? val) {
    _comments = val;
    if (_isRefreshing) {
      notifyListeners();
    }
  }

  bool _isRefreshing = true;
  bool _isCommentsLoading = true;
  bool get isCommentsLoading => _isCommentsLoading;
  set isCommentsLoading(bool val) {
    _isCommentsLoading = val;
    notifyListeners();
  }

  Map<String, int> commentIndexes = <String, int>{};

  Timer? refresh;
  void asyncInit() async {
    await asyncCommentsLoading();
    while (_isRefreshing) {
      await Future.delayed(refreshInterval);
      await asyncCommentsRefresh();
    }
  }

  @override
  void dispose() {
    _isRefreshing = false;
    lvc.dispose();
    super.dispose();
  }

  @override
  CommentModel getCommentById(String commentId) {
    var listIndex = commentIndexes[commentId];
    return comments![listIndex!];
  }

  void initCommentIndexes() {
    commentIndexes = <String, int>{};
    if (comments != null) {
      for (var i = 0; i < comments!.length; i++) {
        commentIndexes.addAll({comments![i].id: i});
      }
    }
  }

  void initializeScrollController() {
    lvc.addListener(() {
      var max = lvc.position.maxScrollExtent;
      var current = lvc.offset;
      var percent = (current / max * 100);
      if (percent > 80) {
        if (!isLoading) {
          isLoading = true;
          Future.delayed(const Duration(seconds: 1)).then((value) async {
            if (comments != null) {
              var upToDate = comments!.last.uploadDate;
              await refreshComments(upToDate: upToDate);
              isLoading = false;
            }
          });
        }
      }
    });
  }

  @override
  void onLikeButtonPressed(String commentId) async {
    await _likeService.likeComment(commentId);
    var refreshedCommentStats = await _dataService.getCommentStats(commentId);
    if (refreshedCommentStats != null) {
      var listIndex = commentIndexes[commentId];
      comments![listIndex!].stats = refreshedCommentStats;
      notifyListeners();
    }
  }

  Future asyncCommentsLoading() async {
    isCommentsLoading = true;
    await refreshComments();
    isCommentsLoading = false;
  }

  Future asyncCommentsRefresh() async {
    if (comments != null) {
      if (comments!.isNotEmpty) {
        var upToDate = comments!.last.uploadDate;
        await refreshComments(upToDate: upToDate);
      } else {
        await refreshComments();
      }
    }
  }

  Future refreshComments({DateTime? upToDate}) async {
    try {
      await syncComments(upToDate: upToDate);
      if (isCommentsLoading || _isRefreshing) {
        if (upToDate != null) {
          var newComments = await loadCommentsFromDB(upToDate: upToDate);
          comments = <CommentModel>[...comments!, ...newComments];
        } else {
          comments = await loadCommentsFromDB();
        }
        initCommentIndexes();
      }
    } on NoNetworkException {
      await displayError("нет сети");
    } on ServerException {
      await displayError("ошибка на сервере");
    }
  }

  Future syncComments({DateTime? upToDate}) async => await _syncService
      .syncComments(postId, commentsUploadAmountPerSync, upToDate: upToDate);

  Future<List<CommentModel>> loadCommentsFromDB({DateTime? upToDate}) async =>
      await _dataService.getComments(postId, upToDate: upToDate);

  @override
  Future displayError(String errorText) async {
    errText = errorText;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      errText = null;
    });
  }
}
