import 'package:json_annotation/json_annotation.dart';

import 'package:ddstudy_ui/domain/db_model.dart';

part 'post.g.dart';

@JsonSerializable()
class Post implements DBModel {
  @override
  final String id;
  final String annotation;
  final String? authorId;
  final String uploadDate;
  Post({
    required this.id,
    required this.annotation,
    this.authorId,
    required this.uploadDate,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  Map<String, dynamic> toMap() => _$PostToJson(this);

  factory Post.fromMap(Map<String, dynamic> map) => _$PostFromJson(map);

  Post copyWith({
    String? id,
    String? annotation,
    String? authorId,
    String? uploadDate,
  }) {
    return Post(
      id: id ?? this.id,
      annotation: annotation ?? this.annotation,
      authorId: authorId ?? this.authorId,
      uploadDate: uploadDate ?? this.uploadDate,
    );
  }
}
