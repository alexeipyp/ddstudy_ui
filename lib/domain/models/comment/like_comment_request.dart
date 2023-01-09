import 'package:json_annotation/json_annotation.dart';

part 'like_comment_request.g.dart';

@JsonSerializable()
class LikeCommentRequest {
  String commentId;

  LikeCommentRequest({
    required this.commentId,
  });

  factory LikeCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$LikeCommentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LikeCommentRequestToJson(this);
}
