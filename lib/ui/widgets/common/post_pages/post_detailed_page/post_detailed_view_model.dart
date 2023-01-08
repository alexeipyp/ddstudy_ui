import 'package:flutter/material.dart';

class PostDetailedViewModel extends ChangeNotifier {
  BuildContext context;
  List<String> postAttachesLinks;
  PageController pageController = PageController(viewportFraction: 1);
  List<TransformationController> zoomControllers = <TransformationController>[];
  PostDetailedViewModel({
    required this.context,
    required this.postAttachesLinks,
  }) {
    init();
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  void onPageChanged(int pageIndex) {
    _pageIndex = pageIndex;
    notifyListeners();
  }

  bool _isScrollLock = false;
  bool get isScrollLock => _isScrollLock;
  set isScrollLock(bool val) {
    _isScrollLock = val;
    notifyListeners();
  }

  void checkScrollLockCondition(int pageIndex) {
    // При увеличении изображения меняются значения диагональных элементов Matrix4
    // При отсутствии увеличения диагональные элементы Matrix4 равны 1
    var dimension = Matrix4.identity().dimension;
    for (int i = 0; i < dimension; i++) {
      var ind = i + i * dimension;
      var val = zoomControllers[pageIndex].value[ind];
      if (val != Matrix4.identity()[ind]) {
        isScrollLock = true;
        return;
      }
    }
    isScrollLock = false;
  }

  void init() {
    for (int i = 0; i < postAttachesLinks.length; i++) {
      zoomControllers.add(TransformationController());
    }
  }
}
