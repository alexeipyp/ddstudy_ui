part of 'iterable_post_display_view_model.dart';

class GridPostDisplayViewModel extends IterablePostDisplayViewModel {
  GridPostDisplayViewModel({
    required BuildContext context,
    required FeedTypeEnum feedType,
    required int postsUploadAmountPerSync,
  }) : super(
          context: context,
          feedType: feedType,
          postsUploadAmountPerSync: postsUploadAmountPerSync,
        );

  void openPostInSinglePage(String postId) {
    Navigator.of(context)
        .pushNamed(AppTabNavigatorRoutes.postAlone, arguments: postId);
  }
}
