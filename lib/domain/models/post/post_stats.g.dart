// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostStats _$PostStatsFromJson(Map<String, dynamic> json) => PostStats(
      id: json['id'] as String?,
      commentsAmount: json['commentsAmount'] as int,
      likesAmount: json['likesAmount'] as int,
      isLiked: json['isLiked'] as bool,
    );

Map<String, dynamic> _$PostStatsToJson(PostStats instance) => <String, dynamic>{
      'id': instance.id,
      'commentsAmount': instance.commentsAmount,
      'likesAmount': instance.likesAmount,
      'isLiked': instance.isLiked,
    };
