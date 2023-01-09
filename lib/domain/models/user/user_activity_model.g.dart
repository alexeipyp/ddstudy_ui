// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActivityModel _$UserActivityModelFromJson(Map<String, dynamic> json) =>
    UserActivityModel(
      postsAmount: json['postsAmount'] as int,
      followersAmount: json['followersAmount'] as int,
      followingAmount: json['followingAmount'] as int,
      subscribeStatus: SubscribeStatus.fromJson(
          json['subscribeStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserActivityModelToJson(UserActivityModel instance) =>
    <String, dynamic>{
      'postsAmount': instance.postsAmount,
      'followersAmount': instance.followersAmount,
      'followingAmount': instance.followingAmount,
      'subscribeStatus': instance.subscribeStatus,
    };
