// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_attach.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAttach _$PostAttachFromJson(Map<String, dynamic> json) => PostAttach(
      id: json['id'] as String,
      name: json['name'] as String,
      mimeType: json['mimeType'] as String,
      attachLink: json['attachLink'] as String,
      postId: json['postId'] as String?,
    );

Map<String, dynamic> _$PostAttachToJson(PostAttach instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mimeType': instance.mimeType,
      'attachLink': instance.attachLink,
      'postId': instance.postId,
    };
