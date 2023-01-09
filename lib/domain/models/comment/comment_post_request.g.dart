// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentPostRequest _$CommentPostRequestFromJson(Map<String, dynamic> json) =>
    CommentPostRequest(
      postId: json['postId'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$CommentPostRequestToJson(CommentPostRequest instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'text': instance.text,
    };
