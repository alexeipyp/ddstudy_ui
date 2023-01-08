import 'package:json_annotation/json_annotation.dart';

part 'like_post_request.g.dart';

@JsonSerializable()
class LikePostRequest {
  final String postId;

  LikePostRequest({
    required this.postId,
  });

  factory LikePostRequest.fromJson(Map<String, dynamic> json) =>
      _$LikePostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LikePostRequestToJson(this);

  LikePostRequest copyWith({
    String? postId,
  }) {
    return LikePostRequest(
      postId: postId ?? this.postId,
    );
  }
}
