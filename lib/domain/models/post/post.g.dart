// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String,
      annotation: json['annotation'] as String,
      authorId: json['authorId'] as String?,
      uploadDate: DateTime.parse(json['uploadDate'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'annotation': instance.annotation,
      'authorId': instance.authorId,
      'uploadDate': instance.uploadDate.toIso8601String(),
    };
