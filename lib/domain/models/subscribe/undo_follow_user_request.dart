// Generated by https://quicktype.io

import 'package:json_annotation/json_annotation.dart';

part 'undo_follow_user_request.g.dart';

@JsonSerializable()
class UndoFollowUserRequest {
  String authorId;

  UndoFollowUserRequest({
    required this.authorId,
  });

  factory UndoFollowUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UndoFollowUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UndoFollowUserRequestToJson(this);
}
