// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as String,
      annotation: json['annotation'] as String?,
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      attaches: (json['attaches'] as List<dynamic>)
          .map((e) => PostAttach.fromJson(e as Map<String, dynamic>))
          .toList(),
      uploadDate: json['uploadDate'] as String,
      stats: PostStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'annotation': instance.annotation,
      'author': instance.author,
      'attaches': instance.attaches,
      'uploadDate': instance.uploadDate,
      'stats': instance.stats,
    };
