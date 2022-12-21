import 'dart:io';
import 'package:flutter/material.dart';

import '../../../internal/dependencies/repository_module.dart';
import '../common/cam_widget.dart';

class CreatePostViewModel extends ChangeNotifier {
  BuildContext context;
  final _api = RepositoryModule.apiRepository();
  CreatePostViewModel({required this.context}) {
    asyncInit();
  }

  List<File> _postAttaches = <File>[];
  List<File> get postAttaches => _postAttaches;
  set postAttaches(List<File> val) {
    _postAttaches = val;
    notifyListeners();
  }

  String? _annotation;
  String? get annotation => _annotation;
  set annotation(String? val) {
    _annotation = val;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void asyncInit() async {}

  Future addPostAttach() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((newContext) => Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: CamWidget(
                  onFile: (file) {
                    postAttaches = [
                      ...postAttaches,
                      file,
                    ];
                    Navigator.of(newContext).pop();
                  },
                ),
              ),
            )),
      ),
    );
  }

  Future createPost() async {
    isLoading = true;

    if (postAttaches.isNotEmpty && (annotation?.isNotEmpty ?? false)) {
      var attaches = await _api.uploadTemp(files: postAttaches);
      await _api.createPost(annotation!, attaches);
      postAttaches = <File>[];
    }

    isLoading = false;
  }
}
