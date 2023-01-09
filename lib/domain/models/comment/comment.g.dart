// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      text: json['text'] as String,
      authorId: json['authorId'] as String?,
      postId: json['postId'] as String?,
      uploadDate: DateTime.parse(json['uploadDate'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'text': instance.text,
      'authorId': instance.authorId,
      'uploadDate': instance.uploadDate.toIso8601String(),
    };
