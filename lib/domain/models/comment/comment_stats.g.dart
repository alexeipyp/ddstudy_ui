// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentStats _$CommentStatsFromJson(Map<String, dynamic> json) => CommentStats(
      id: json['id'] as String?,
      likesAmount: json['likesAmount'] as int,
      whenLiked: json['whenLiked'] == null
          ? null
          : DateTime.parse(json['whenLiked'] as String),
    );

Map<String, dynamic> _$CommentStatsToJson(CommentStats instance) =>
    <String, dynamic>{
      'id': instance.id,
      'likesAmount': instance.likesAmount,
      'whenLiked': instance.whenLiked?.toIso8601String(),
    };
