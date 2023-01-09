import 'package:json_annotation/json_annotation.dart';

import 'package:ddstudy_ui/domain/db_model.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment implements DBModel {
  @override
  final String id;
  final String? postId;
  final String text;
  final String? authorId;
  final DateTime uploadDate;
  Comment({
    required this.id,
    required this.text,
    this.authorId,
    this.postId,
    required this.uploadDate,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  Map<String, dynamic> toMap() => _$CommentToJson(this);

  factory Comment.fromMap(Map<String, dynamic> map) => _$CommentFromJson(map);

  Comment copyWith({
    String? id,
    String? postId,
    String? text,
    String? authorId,
    DateTime? uploadDate,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      text: text ?? this.text,
      authorId: authorId ?? this.authorId,
      uploadDate: uploadDate ?? this.uploadDate,
    );
  }
}
