// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActivity _$UserActivityFromJson(Map<String, dynamic> json) => UserActivity(
      postsAmount: json['postsAmount'] as int,
      followersAmount: json['followersAmount'] as int,
      followingAmount: json['followingAmount'] as int,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$UserActivityToJson(UserActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postsAmount': instance.postsAmount,
      'followersAmount': instance.followersAmount,
      'followingAmount': instance.followingAmount,
    };
