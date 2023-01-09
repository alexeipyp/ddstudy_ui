// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as String,
      text: json['text'] as String,
      uploadDate: DateTime.parse(json['uploadDate'] as String),
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      stats: CommentStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'uploadDate': instance.uploadDate.toIso8601String(),
      'author': instance.author,
      'stats': instance.stats,
    };
