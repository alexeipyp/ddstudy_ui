import 'package:json_annotation/json_annotation.dart';

import 'package:ddstudy_ui/domain/db_model.dart';

part 'post_attach.g.dart';

@JsonSerializable()
class PostAttach implements DBModel {
  @override
  final String id;
  final String name;
  final String mimeType;
  final String attachLink;
  final String? postId;
  PostAttach({
    required this.id,
    required this.name,
    required this.mimeType,
    required this.attachLink,
    this.postId,
  });

  factory PostAttach.fromJson(Map<String, dynamic> json) =>
      _$PostAttachFromJson(json);
  Map<String, dynamic> toJson() => _$PostAttachToJson(this);

  @override
  Map<String, dynamic> toMap() => _$PostAttachToJson(this);

  factory PostAttach.fromMap(Map<String, dynamic> map) =>
      _$PostAttachFromJson(map);

  PostAttach copyWith({
    String? id,
    String? name,
    String? mimeType,
    String? attachLink,
    String? postId,
  }) {
    return PostAttach(
      id: id ?? this.id,
      name: name ?? this.name,
      mimeType: mimeType ?? this.mimeType,
      attachLink: attachLink ?? this.attachLink,
      postId: postId ?? this.postId,
    );
  }
}
